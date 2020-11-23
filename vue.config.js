module.exports = {
    publicPath: process.env.NODE_ENV === 'production' ? '/genshin_timer' : '/',
    pages: {
        index: {
            entry: 'src/main.js',
            title: 'Genshin Timer'
        }
    }
}