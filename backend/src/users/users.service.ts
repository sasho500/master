import { Injectable, Logger, UnauthorizedException, ForbiddenException  } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './user.entity';

@Injectable()
export class UsersService {
    private readonly logger = new Logger(UsersService.name);
    private saltRounds = 12;  // Increased salt rounds for bcrypt

    constructor(
        @InjectRepository(User)
        private usersRepository: Repository<User>,
    ) {}
    private readonly MAX_FAILED_ATTEMPTS = 5;
    private readonly LOCK_TIME = 1 * 60 * 1000; // 30 minutes

    async findAll(): Promise<User[]> {
        try {
            const users = await this.usersRepository.find();
            this.logger.log(`Found ${users.length} users`);
            return users;
        } catch (error) {
            this.logger.error('Failed to retrieve users', error.stack);
            throw new Error('Error retrieving users');
        }
    }

    async findOne(key: string): Promise<User> {
        try {
            const user = await this.usersRepository.findOne({ where: { key } });
            if (user) {
                this.logger.log(`User found`);
            } else {
                this.logger.log('User not found');
            }
            return user;
        } catch (error) {
            this.logger.error('Error retrieving user', error.stack);
            throw new Error('User retrieval failed');
        }
    }

    async update(key: string, userData: Partial<User>): Promise<User> {
        try {
            const user = await this.usersRepository.findOne({ where: { key } });
            if (!user) {
                throw new Error('User not found');
            }

            // Update password with hashing if it is being changed
            if (userData.password) {
                userData.password = await bcrypt.hash(userData.password, this.saltRounds);
            }

            await this.usersRepository.update(user.user_id, userData);
            const updatedUser = await this.usersRepository.findOne({ where: { user_id: user.user_id } });
            
            return updatedUser;
        } catch (error) {
            this.logger.error('Failed to update user', error.stack);
            throw new Error('Update failed');
        }
    }

    async remove(key: string): Promise<void> {
        try {
            const deleteResult = await this.usersRepository.delete({ key });
            if (!deleteResult.affected) {
                throw new Error('No user was deleted');
            }
            this.logger.log('User deleted');
        } catch (error) {
            this.logger.error('Failed to delete user', error.stack);
            throw new Error('Deletion failed');
        }
    }
    async validateLogin(username: string, password: string): Promise<User | null> {
        const user = await this.usersRepository.findOne({ where: { username } });
        if (!user) {
            this.logger.log(`User not found with username: ${username}`);
            await this.delayResponse();
            return null;
        }

        if (user.lockedUntil && user.lockedUntil > new Date()) {
            this.logger.warn(`Account is locked until ${user.lockedUntil}`);
            throw new ForbiddenException('Account is temporarily locked');
        }

        this.logger.debug(`Entered password: ${password}`);
        this.logger.debug(`Stored hashed password: ${user.password}`);

        const isPasswordMatching = await bcrypt.compare(password, user.password);
        this.logger.debug(`isPasswordMatching: ${isPasswordMatching}`);

        if (isPasswordMatching) {
            user.failedLoginAttempts = 0; // Reset on successful login
            await this.usersRepository.save(user);
            this.logger.log(`User ${username} login successful`);
            return user;
        } else {
            user.failedLoginAttempts = (user.failedLoginAttempts || 0) + 1;
            this.logger.warn(`Failed login attempt ${user.failedLoginAttempts} for user: ${username}`);
        
            if (user.failedLoginAttempts >= this.MAX_FAILED_ATTEMPTS) {
                user.lockedUntil = new Date(Date.now() + this.LOCK_TIME); // Lock for 30 minutes
                this.logger.warn(`Account locked until ${user.lockedUntil} due to too many failed login attempts`);
            }
        
            await this.usersRepository.save(user);
            await this.delayResponse();
            return null;
        }
    }
    
      private async delayResponse(): Promise<void> {
        return new Promise((resolve) => setTimeout(resolve, 1000)); // 1-second delay
      }

    async findByUsername(username: string): Promise<User> {
        try {
            const user = await this.usersRepository.findOne({ where: { username } });
            return user;
        } catch (error) {
            this.logger.error('Error retrieving user by username', error.stack);
            throw new Error('User retrieval failed');
        }
    }

    async create(userData: Partial<User>): Promise<User> {
        // Hash password before saving
        if (userData.password) {
            userData.password = await bcrypt.hash(userData.password, this.saltRounds);
        }
        const newUser = this.usersRepository.create(userData);
        return this.usersRepository.save(newUser);
    }
}