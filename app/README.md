# EPA IWTT web app

Web version of EPA's Industrial Wastewater Treatment Technology (IWTT) database, built with React and Redux.

## Deployment

Each environment has a dotenv file containing environment-specific settings ([`.env.development`](/.env.development), [`.env.staging`](/.env.staging), [`.env.production`](/.env.production)). If the application base path or the web service url ever need to change, they can be updated in each environment's dotenv file as needed.

### Development

1. After all changes have been made to the code, open the [`.env.development`](/.env.development) file and update the `VITE_APP_BASE_PATH` environment variable to reflect the current date (e.g., `/iwtt/2025-01-01`).

2.  Run `npm run build:dev` to build the project for hosting on the development server.

3.  Upload the contents of the `build` directory into a newly created "iwtt/date" subdirectory on the development server. _**IMPORTANT:** this newly created directory must match the environment variable's value used in step 1 above (e.g., https://projects.erg.com/iwtt/2025-01-01)_.

### EPA Staging

1.  Run `npm run build:stage` to build the project for hosting on EPA’s staging server.

2.  Duplicate the `build` directory, rename it to include "iwtt-stage-" and the current date, and create a zip archive of the directory (e.g., `iwtt-stage-2025-01-01.zip`).

3. Send the zipped archive to EPA for staging deployment.

### EPA Production

_***NOTE:*** After obtaining the production API key, deploying for production is exactly the same as staging, except the npm script and zipped archive named differently:_

1.  Obtain a production API key from https://api.data.gov/signup/. Update the [`.env.production`](/.env.production) file's `VITE_WEB_SERVICE_PARAMS` environment variable to include the API key's value. Be sure to continue to include `api_key=` before the actual API key's value (for example: `VITE_WEB_SERVICE_PARAMS='api_key=abc123xyz'`).

2.  Run `npm run build:prod` to build the project for hosting on EPA’s production server.

3.  Duplicate the `build` directory, rename it to include "iwtt-prod-" and the current date, and create a zip archive of the directory (e.g., `iwtt-prod-2025-01-01.zip`).

4. Send the zipped archive to EPA for production deployment.
