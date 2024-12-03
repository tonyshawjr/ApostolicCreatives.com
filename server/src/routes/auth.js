import express from 'express';
import jwt from 'jsonwebtoken';
import User from '../models/User.js';
import CreativeProfile from '../models/CreativeProfile.js';
import PartnerProfile from '../models/PartnerProfile.js';

const router = express.Router();

// Login endpoint
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    if (!email || !password) {
      return res.status(400).json({ message: 'Email and password are required' });
    }

    console.log('Login attempt for email:', email);

    // Find user by email
    const user = await User.findOne({ where: { email } });
    if (!user) {
      console.log('User not found');
      return res.status(401).json({ message: 'Invalid email or password' });
    }
    console.log('User found:', { id: user.id, email: user.email, role: user.role });

    // Validate password using the User model method
    const isValidPassword = await user.validatePassword(password);
    console.log('Password valid:', isValidPassword);
    
    if (!isValidPassword) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    // Check if user is active
    if (user.status !== 'active') {
      return res.status(403).json({ message: 'Account is not active' });
    }

    // Create JWT token
    const token = jwt.sign(
      { 
        id: user.id, 
        email: user.email, 
        role: user.role 
      },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    // Update last login
    await user.update({ lastLogin: new Date() });

    // Send response with user type-specific profile
    const userResponse = {
      id: user.id,
      email: user.email,
      role: user.role,
      status: user.status
    };

    if (user.role === 'creative') {
      const profile = await CreativeProfile.findOne({ where: { userId: user.id } });
      if (profile) {
        userResponse.profile = profile;
      }
    } else if (user.role === 'partner') {
      const profile = await PartnerProfile.findOne({ where: { userId: user.id } });
      if (profile) {
        userResponse.profile = profile;
      }
    }

    res.json({
      token,
      user: userResponse
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Internal server error during login' });
  }
});

// Get current user endpoint
router.get('/me', async (req, res) => {
  try {
    // Get token from header
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ message: 'No token provided' });
    }

    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    // Get user
    const user = await User.findByPk(decoded.id);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Check if user is active
    if (user.status !== 'active') {
      return res.status(403).json({ message: 'Account is not active' });
    }

    // Send response
    res.json({
      id: user.id,
      email: user.email,
      role: user.role,
      status: user.status
    });
  } catch (error) {
    console.error('Auth check error:', error);
    if (error.name === 'JsonWebTokenError') {
      return res.status(401).json({ message: 'Invalid token' });
    }
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ message: 'Token expired' });
    }
    res.status(500).json({ message: 'Internal server error during authentication' });
  }
});

export default router;
