//You need this file to start your server
const express = require ('express')
const app = express();

//You need this to parse json stuff, middlewares
app.use(express.json());
app.use(express.urlencoded({extended: false}));



//Here you define the routes you want for your API
app.use(require('./routes/personRoutes'));

app.listen(3000);
console.log('Server is running on port 3000')
