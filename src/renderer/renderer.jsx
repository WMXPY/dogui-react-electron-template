import React from 'react';
import ReactDOM from 'react-dom';
import { AppContainer } from 'react-hot-loader'
import App from './app.jsx';

const render = (App) => {
    ReactDOM.render(
        <AppContainer>
            <App />
        </AppContainer>,
        document.getElementById('root')
    )
}

render(App)
if (module.hot) {
    module.hot.accept('./app.jsx', () => render(App))
}