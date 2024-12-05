import { Model, DataTypes } from 'sequelize';
import bcrypt from 'bcryptjs';
import sequelize from '../config/database.js';

class User extends Model {
  static async hashPassword(password) {
    try {
      console.log('Hashing password of length:', password.length);
      const salt = await bcrypt.genSalt(10);
      console.log('Generated salt:', salt);
      const hash = await bcrypt.hash(password, salt);
      console.log('Generated hash:', hash);
      return hash;
    } catch (error) {
      console.error('Password hashing error:', error);
      throw error;
    }
  }

  async validatePassword(password) {
    try {
      console.log('\n🔐 Password Validation Details');
      console.log('----------------------------');
      console.log('Input password length:', password.length);
      console.log('Stored hash:', this.password);
      const result = await bcrypt.compare(password, this.password);
      console.log('bcrypt.compare result:', result ? '✅ Valid' : '❌ Invalid');
      return result;
    } catch (error) {
      console.error('❌ Password validation error:', error);
      return false;
    }
  }
}

User.init(
  {
    user_id: {
      type: DataTypes.CHAR(8),
      primaryKey: true,
    },
    email: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: true,
      validate: {
        isEmail: true,
      },
    },
    password: {
      type: DataTypes.STRING(255),
      allowNull: false,
      set(value) {
        // Don't hash if it's already a hash
        if (value.startsWith('$2a$')) {
          this.setDataValue('password', value);
        } else {
          // Only hash if it's a plain password
          const hashedPassword = bcrypt.hashSync(value, 10);
          this.setDataValue('password', hashedPassword);
        }
      }
    },
    first_name: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    last_name: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    user_type: {
      type: DataTypes.ENUM('creative', 'partner', 'team'),
      allowNull: false,
    },
    status: {
      type: DataTypes.ENUM('active', 'inactive', 'pending'),
      defaultValue: 'pending',
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
    last_login: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    profile_photo_url: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    timezone: {
      type: DataTypes.STRING(50),
      defaultValue: 'UTC',
    },
    contact_phone: {
      type: DataTypes.STRING(20),
      allowNull: true,
    },
    address_line1: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    address_line2: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    city: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    state: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    postal_code: {
      type: DataTypes.STRING(20),
      allowNull: true,
    },
    country: {
      type: DataTypes.STRING(100),
      allowNull: true,
    }
  },
  {
    sequelize,
    modelName: 'User',
    tableName: 'users',
    timestamps: false, // We're using created_at manually
    hooks: {
      beforeCreate: async (user) => {
        if (user.password) {
          // Removed hashing here
        }
      },
      beforeUpdate: async (user) => {
        if (user.changed('password')) {
          // Removed hashing here
        }
      }
    }
  }
);

export default User;
