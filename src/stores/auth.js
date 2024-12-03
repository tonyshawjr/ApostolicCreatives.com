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
    userRole: (state) => state.user?.role,
  },

  actions: {
    async login({ email, password }) {
      try {
        this.loading = true;
        this.error = null;
        
        const response = await axios.post('http://localhost:4000/api/auth/login', { email, password });
        
        this.token = response.data.token;
        this.user = response.data.user;
        localStorage.setItem('token', this.token);
        localStorage.setItem('user', JSON.stringify(response.data.user));
        axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
        
        return { success: true };
      } catch (error) {
        this.error = error.response?.data?.message || 'Login failed';
        return { 
          success: false, 
          error: this.error 
        };
      } finally {
        this.loading = false;
      }
    },

    async register(userData) {
      try {
        this.loading = true;
        this.error = null;
        const response = await axios.post('http://localhost:4000/api/auth/register', userData);
        this.token = response.data.token;
        this.user = response.data.user;
        localStorage.setItem('token', this.token);
        localStorage.setItem('user', JSON.stringify(response.data.user));
        axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
        return { success: true };
      } catch (error) {
        this.error = error.response?.data?.message || 'Registration failed';
        return {
          success: false,
          error: this.error
        };
      } finally {
        this.loading = false;
      }
    },

    async logout() {
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
        return { success: true };
      } catch (error) {
        this.logout();
        return {
          success: false,
          error: error.response?.data?.message || 'Failed to fetch user'
        };
      }
    },
  },
});
