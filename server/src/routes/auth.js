import express from 'express';
import jwt from 'jsonwebtoken';
import User from '../models/User.js';

const router = express.Router();

// Login endpoint
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    console.log('\n==================================');
    console.log('🔐 LOGIN ATTEMPT');
    console.log('==================================');
    console.log('📧 Email:', email);
    
    if (!email || !password) {
      console.log('❌ Missing credentials');
      return res.status(400).json({ message: 'Email and password are required' });
    }

    // Find user by email
    const user = await User.findOne({ where: { email } });
    
    if (!user) {
      console.log('❌ User not found');
      return res.status(401).json({ message: 'Invalid email or password' });
    }
    
    console.log('✅ User found:', {
      id: user.user_id,
      email: user.email,
      type: user.user_type,
      status: user.status
    });

    // Validate password
    console.log('\n🔑 Password Validation');
    console.log('------------------------');
    console.log('Password received (length):', password.length);
    console.log('Stored hash:', user.password);
    
    const isValidPassword = await user.validatePassword(password);
    console.log('Password validation result:', isValidPassword ? '✅ Valid' : '❌ Invalid');
    
    if (!isValidPassword) {
      console.log('❌ Invalid password');
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    // Check if user is active
    if (user.status !== 'active') {
      console.log('❌ Account not active');
      return res.status(403).json({ message: 'Account is not active' });
    }

    // Update last login time
    await user.update({
      last_login: new Date()
    });

    // Create JWT token
    const tokenPayload = { 
      id: user.user_id,
      email: user.email,
      type: user.user_type,
      firstName: user.first_name,
      lastName: user.last_name
    };
    console.log('\n🔒 Token Creation');
    console.log('------------------');
    console.log('Creating token with payload:', tokenPayload);

    const token = jwt.sign(
      tokenPayload,
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '24h' }
    );

    const response = {
      user: {
        id: user.user_id,
        email: user.email,
        type: user.user_type,
        firstName: user.first_name,
        lastName: user.last_name,
        status: user.status,
        profilePhotoUrl: user.profile_photo_url
      },
      token
    };

    console.log('\n📦 Response');
    console.log('------------');
    console.log('Sending response:', {
      ...response,
      token: token ? '[TOKEN PRESENT]' : '[NO TOKEN]'
    });

    res.json(response);

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get current user endpoint
router.get('/me', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ message: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const user = await User.findOne({ where: { user_id: decoded.id } });
    
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({
      id: user.user_id,
      email: user.email,
      type: user.user_type,
      firstName: user.first_name,
      lastName: user.last_name,
      status: user.status,
      profilePhotoUrl: user.profile_photo_url
    });
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(401).json({ message: 'Invalid token' });
  }
});

export default router;
