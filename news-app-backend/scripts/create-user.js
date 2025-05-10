const mongoose = require('mongoose');
require('dotenv').config();

// MongoDB Atlas Connection
const MONGODB_URI = process.env.MONGODB_URI;
mongoose.connect(MONGODB_URI)
  .then(() => console.log('Connected to MongoDB Atlas'))
  .catch(err => console.error('MongoDB connection error:', err));

// Create a simple user schema
const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const User = mongoose.model('User', userSchema);

// Create a test user
const createTestUser = async () => {
  try {
    const testUser = new User({
      username: 'testuser',
      email: 'test@example.com'
    });

    const savedUser = await testUser.save();
    console.log('Test user created:', savedUser);

    // Print the user ID for reference in the Flutter app
    console.log('Use this user ID in your Flutter app:', savedUser._id);
  } catch (error) {
    console.error('Error creating test user:', error);
  } finally {
    mongoose.disconnect();
  }
};

createTestUser();