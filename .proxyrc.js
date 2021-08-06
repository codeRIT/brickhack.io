// Allows resources (images, css) from other origins to be used
// Without this, parcel 2 blocks all external resources
// See https://git.io/JRYKi
module.exports = function (app) {
    app.use((req, res, next) => {
        res.removeHeader('Cross-Origin-Resource-Policy');
        res.removeHeader('Cross-Origin-Embedder-Policy');
        next();
    });
};
