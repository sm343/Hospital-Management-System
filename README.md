# Hospital-Management-System

How to start the project at your localhost?

Requirements: NodeJS, NPM package manager and mySQL

In MySQL workbench, run the SQL file 'Hospital Database.sql'

In file Backend/server.js, enter user and password of your SQL server at line 10 and 11.

Steps: 
1. Install Node and npm. For the installation, the steps can be followed from here: https://phoenixnap.com/kb/install-node-js-npm-on-windows
2. Download the zip file and extract the zip folder.
3. Open the terminal inside the zip folder.
4. Open the 'Hospital Management System' folder in the terminal.
5. Run the following commands:
   (a) cd Frontend
   (b) npm i
   (c) npm run dev
   Then open the url that is shown in the terminal.
6. Open a new terminal (parallely) in the same folder.
7. Run the following commands:
   (a) cd Backend
   (b) npm i
   (c) npm start
   
Note: Steps 5 and 7 should be done in separate terminal window simultaneously.
   
In your browser, open the url: http://localhost:8081
If it shows an error, run the following query in MySQL: ALTER USER 'user'@'localhost' IDENTIFIED BY 'password'; and do npm start in the Backend directory again. The app is now hosted at localhost:8081

Finally, open the url generated in the 5th step in your browser.
