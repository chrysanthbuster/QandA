export const server = 'http://localhost:35672';
export const webAPIUrl = `${server}/api`;

export const authSettings = {
    domain: 'dev-5und1roc.us.auth0.com',
    client_id: 'ScdJ2FRVXwhvRhIoAPXnP1NbrzsSawlO',
    redirect_uri: 'https://' + window.location.host + '/signin-callback',
    scope: 'openid profile QandAAPI email',
    audience: 'https://qanda',
};
