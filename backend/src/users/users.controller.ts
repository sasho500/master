import { Controller, Get, Body, Param, Delete, Put } from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './user.entity';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // @Get()
  // getAllUsers(): Promise<User[]> {
  //   return this.usersService.findAll();
  // }

  @Get(':key')
  getUser(@Param('key') key: string): Promise<User> {
    return this.usersService.findOne(key);
  }

  @Put(':key')
  updateUser(@Param('key') key: string, @Body() userData: User): Promise<User> {
    return this.usersService.update(key, userData);
  }

  @Delete(':key')
  deleteUser(@Param('key') key: string): Promise<void> {
    return this.usersService.remove(key);
  }
}
