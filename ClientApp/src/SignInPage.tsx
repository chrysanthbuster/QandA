import React from 'react';
import { StatusText } from './Styles';

import { Page } from './Page';

import { useAuth } from './Auth';

type SigninAction = 'signin' | 'signin-callback';

interface Props {
    action: SigninAction;
}

export const SignInPage = ({ action }: Props) => {
    const { signIn } = useAuth();
    if (action === 'signin') {
        signIn();
    }
    return (
        <Page title="Sign In">
            <StatusText>Signing in ...</StatusText>
        </Page>
    );
};
