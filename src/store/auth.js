import { defineStore } from 'pinia';
import axios from 'axios';

// Create an axios instance with the base URL
const api = axios.create({
  baseURL: 'http://localhost:3000',
  timeout: 5000,
});

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token') || null,
    loading: false,
    error: null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    userRole: (state) => state.user?.role || null,
  },

  actions: {
    async login(email, password) {
      this.loading = true;
      this.error = null;
      
      try {
        const response = await api.post('/api/auth/login', {
          email: email.replace('@apostolicsoncall.com', '@apostoliccreatives.com'),
          password,
        });

        const { token, user } = response.data;
        
        this.token = token;
        this.user = user;
        
        localStorage.setItem('token', token);
        
        // Set the default Authorization header for future requests
        api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
        
        return user;
      } catch (error) {
        console.error('Login error:', error);
        this.error = error.response?.data?.message || 'Login failed';
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('token');
      delete api.defaults.headers.common['Authorization'];
    },

    async checkAuth() {
      if (!this.token) return;

      try {
        const response = await api.get('/api/auth/me');
        this.user = response.data;
      } catch (error) {
        this.logout();
      }
    },
  },
});
