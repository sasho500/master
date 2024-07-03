import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import helmet from 'helmet';
// import * as csurf from 'csurf';
import * as session from 'express-session';
import { ConfigService } from '@nestjs/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Helmet middleware for setting various HTTP headers
  app.use(helmet());

  // Content Security Policy configuration
  app.use(
    helmet.contentSecurityPolicy({
      directives: {
        defaultSrc: ["'self'"],
        scriptSrc: ["'self'", 'https://trustedscripts.example.com'],
        styleSrc: ["'self'", 'https://trustedstyles.example.com'],
        imgSrc: ["'self'", 'https://trustedimages.example.com'],
        connectSrc: ["'self'", 'https://api.example.com'],
        fontSrc: ["'self'", 'https://fonts.example.com'],
        objectSrc: ["'none'"],
        upgradeInsecureRequests: [],
      },
    }),
  );

  // Enable CORS for specific origins
  app.enableCors({
    origin: process.env.FRONTEND_DOMAIN,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });

  // Session management
  app.use(
    session({
      secret: 'defaultSecretKey', // You should use a secure secret key here
      resave: false,
      saveUninitialized: false,
      cookie: {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production', // Set to true if using HTTPS
      },
    }),
  );

  // CSRF protection
  // app.use(csurf());

  await app.listen(3000);
}
bootstrap();
