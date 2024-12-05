import { defineStore } from 'pinia';
import axios from 'axios';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')) || null,
    token: localStorage.getItem('token') || null,
    loading: false,
    error: null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    userType: (state) => state.user?.type,
  },

  actions: {
    async login(credentials) {
      try {
        console.log('Auth store: Starting login request...');
        this.loading = true;
        this.error = null;
        
        console.log('Auth store: Sending request to server...');
        const response = await axios.post('http://localhost:4000/api/auth/login', credentials);
        console.log('Auth store: Received response:', {
          status: response.status,
          hasToken: !!response.data.token,
          hasUser: !!response.data.user
        });
        
        if (!response.data.token || !response.data.user) {
          console.error('Auth store: Invalid response structure:', response.data);
          throw new Error('Invalid response from server');
        }
        
        this.token = response.data.token;
        this.user = response.data.user;
        
        // Store in localStorage
        localStorage.setItem('token', this.token);
        localStorage.setItem('user', JSON.stringify(this.user));
        
        // Set default auth header
        axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
        
        console.log('Auth store: Login successful, user:', this.user);
        return { success: true };
      } catch (error) {
        console.error('Auth store: Login error:', error);
        console.error('Auth store: Error details:', {
          message: error.message,
          response: error.response?.data,
          status: error.response?.status
        });
        
        this.error = error.response?.data?.message || 'Login failed. Please check your credentials.';
        return { 
          success: false, 
          error: this.error 
        };
      } finally {
        this.loading = false;
      }
    },

    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      delete axios.defaults.headers.common['Authorization'];
    },

    async fetchUser() {
      try {
        const response = await axios.get('http://localhost:4000/api/auth/me');
        this.user = response.data;
        localStorage.setItem('user', JSON.stringify(this.user));
        return { success: true };
      } catch (error) {
        console.error('Error fetching user:', error);
        if (error.response?.status === 401) {
          this.logout();
        }
        return { success: false, error: error.message };
      }
    }
  },
});
