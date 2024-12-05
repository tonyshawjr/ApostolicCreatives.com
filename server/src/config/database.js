import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

const sequelize = new Sequelize('apostolic_creatives', 'root', 'root', {
    host: '127.0.0.1',  // Using IP instead of localhost
    port: 8889,
    dialect: 'mysql',
    logging: process.env.NODE_ENV === 'development' ? console.log : false,
    define: {
      timestamps: true,
      underscored: true,
    },
    dialectOptions: {
      // For MAMP setup
      socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
    },
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  }
);

export default sequelize;
