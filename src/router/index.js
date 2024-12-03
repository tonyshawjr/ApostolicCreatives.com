import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import MainLayout from '../layouts/MainLayout.vue'
import PublicLayout from '../layouts/PublicLayout.vue'

const routes = [
  // Public Routes
  {
    path: '/',
    component: PublicLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import('../views/public/Home.vue')
      },
      {
        path: 'about',
        name: 'About',
        component: () => import('../views/public/About.vue')
      },
      {
        path: 'faq',
        name: 'FAQ',
        component: () => import('../views/public/FAQ.vue')
      },
      {
        path: 'contact',
        name: 'Contact',
        component: () => import('../views/public/Contact.vue')
      },
      {
        path: 'pricing',
        name: 'Pricing',
        component: () => import('../views/public/Pricing.vue')
      },
      {
        path: 'testimonials',
        name: 'Testimonials',
        component: () => import('../views/public/Testimonials.vue')
      },
      {
        path: 'blog',
        name: 'Blog',
        component: () => import('../views/public/Blog.vue')
      },
      {
        path: 'why-us',
        name: 'WhyUs',
        component: () => import('../views/public/WhyUs.vue')
      },
      {
        path: 'login',
        name: 'Login',
        component: () => import('../views/auth/Login.vue')
      },
      {
        path: 'register',
        name: 'Register',
        component: () => import('../views/auth/Register.vue')
      }
    ]
  },
  // Creative Routes
  {
    path: '/creative',
    component: MainLayout,
    meta: { requiresAuth: true, role: 'creative' },
    children: [
      {
        path: '',
        redirect: { name: 'CreativeDashboard' }
      },
      {
        path: 'dashboard',
        name: 'CreativeDashboard',
        component: () => import('../views/creative/Dashboard.vue'),
      },
      {
        path: 'profile',
        name: 'CreativeProfile',
        component: () => import('../views/creative/Profile.vue'),
      },
      {
        path: 'verification',
        name: 'PastorVerification',
        component: () => import('../views/creative/PastorVerification.vue'),
      },
      {
        path: 'jobs',
        name: 'JobBoard',
        component: () => import('../views/creative/JobBoard.vue'),
      },
      {
        path: 'applications',
        name: 'MyApplications',
        component: () => import('../views/creative/Applications.vue'),
      },
      {
        path: 'messages',
        name: 'Messages',
        component: () => import('../views/creative/Messages.vue'),
      },
      {
        path: 'subscription',
        name: 'Subscription',
        component: () => import('../views/creative/Subscription.vue'),
      }
    ]
  },
  // Partner Routes
  {
    path: '/partner',
    component: MainLayout,
    meta: { requiresAuth: true, role: 'partner' },
    children: [
      {
        path: 'dashboard',
        name: 'PartnerDashboard',
        component: () => import('../views/partner/Dashboard.vue'),
      }
    ]
  },
  // Admin Routes
  {
    path: '/admin',
    component: MainLayout,
    meta: { requiresAuth: true, role: 'admin' },
    children: [
      {
        path: '',
        redirect: { name: 'AdminDashboard' }
      },
      {
        path: 'dashboard',
        name: 'AdminDashboard',
        component: () => import('../views/admin/Dashboard.vue')
      },
      {
        path: 'verifications',
        name: 'AdminVerifications',
        component: () => import('../views/admin/Verifications.vue')
      },
      {
        path: 'users',
        name: 'AdminUsers',
        component: () => import('../views/admin/Users.vue')
      },
      {
        path: 'jobs',
        name: 'AdminJobs',
        component: () => import('../views/admin/Jobs.vue')
      },
      {
        path: 'subscriptions',
        name: 'AdminSubscriptions',
        component: () => import('../views/admin/Subscriptions.vue')
      },
      {
        path: 'reports',
        name: 'AdminReports',
        component: () => import('../views/admin/Reports.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth)
  const requiredRole = to.matched.find(record => record.meta.role)?.meta.role

  if (requiresAuth && !authStore.isAuthenticated) {
    next('/login')
  } else if (requiredRole && authStore.userRole !== requiredRole) {
    next('/')
  } else {
    next()
  }
})

export default router
