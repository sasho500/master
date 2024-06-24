import { Injectable, Logger } from '@nestjs/common';
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
        if (user && await bcrypt.compare(password, user.password)) {
            return user;
        }
        return null;
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