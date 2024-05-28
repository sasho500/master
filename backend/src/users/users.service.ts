import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './user.entity';

@Injectable()
export class UsersService {
    private readonly logger = new Logger(UsersService.name);

    constructor(
        @InjectRepository(User)
        private usersRepository: Repository<User>,
    ) {}

    async findAll(): Promise<User[]> {
        try {
            const users = await this.usersRepository.find();
            this.logger.log(`Found ${users.length} users`);
            return users;
        } catch (error) {
            this.logger.error('Failed to find all users', error.stack);
            throw error;
        }
    }

    async findOne(key: string): Promise<User> {
      try {
        const user = await this.usersRepository.findOne({ where: { key } });
        if (user) {
            this.logger.log(`Found user: ${JSON.stringify(user)}`);
        } else {
            this.logger.log('No user found with the given key');
        }
        return user;
    } catch (error) {
        this.logger.error(`Error finding user with key ${key}`, error.stack);
        throw error;
    }
    }

    async update(key: string, userData: Partial<User>): Promise<User> {
        try {
            const updateResult = await this.usersRepository.update(key, userData);
            if (!updateResult.affected) {
                throw new Error('No user was updated');
            }
            const updatedUser = await this.usersRepository.findOne({ where: { key: key }});
            return updatedUser;
        } catch (error) {
            this.logger.error(`Failed to update user with key ${key}`, error.stack);
            throw error;
        }
    }

    async remove(key: string): Promise<void> {
        try {
            const deleteResult = await this.usersRepository.delete(key);
            if (!deleteResult.affected) {
                throw new Error('No user was deleted');
            }
            this.logger.log(`Deleted user with key ${key}`);
        } catch (error) {
            const newError = new Error('Failed to delete user');
            newError.stack = error.stack;
            this.logger.error(newError.message, newError.stack);
            throw newError;
        }
    }

    async validateLogin(username: string, password: string): Promise<User | null> {
      const user = await this.usersRepository.findOne({ where: { username, password } }); // Add hashing for password
      if (user && await bcrypt.compare(password, user.password)) {
        return user;
      }
      return null;
    }

    async create(userData: Partial<User>): Promise<User> {
      const newUser = this.usersRepository.create(userData);
      return this.usersRepository.save(newUser);
    }
}
