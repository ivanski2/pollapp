const path = require('path');

module.exports = {
    mode: 'development',
    entry: './app/javascript/application.js',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'public/packs'),
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            }
        ]
    }
};
