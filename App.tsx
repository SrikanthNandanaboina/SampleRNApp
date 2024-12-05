/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { NavigationContainer } from '@react-navigation/native';
import { StackNavigationProp, createStackNavigator } from '@react-navigation/stack';
import React, { useEffect } from 'react';
import { Button, NativeEventEmitter, NativeModules, StyleSheet, View } from 'react-native';

const { UpswingModuleEmitter } = NativeModules;

type RootStackParamList = {
    Home: undefined;
};

type HomeScreenProps = {
    navigation: StackNavigationProp<RootStackParamList, 'Home'>;
};

const fetchICIAndGSTData = async(userId: string) => {
	return {};
};

const App: React.FC = () => {
   useEffect(() => {
    const eventEmitter = new NativeEventEmitter(UpswingModuleEmitter);
    const eventListener = eventEmitter.addListener('upswingApiCall', event => {
      const fetchICIAndGSTUsingPCI = async () => {
          try {
            const tokens = await fetchICIAndGSTData("test");
            UpswingModuleEmitter.upswingSuccess(tokens.ici, tokens.guestSessionToken);
          } catch (error) {
            console.log(error);
            UpswingModuleEmitter.upswingFailure();
          }
      };

      // Call the API function
      fetchICIAndGSTUsingPCI();

    });

    return () => {
      eventListener.remove();
    };
  }, []);

    const HomeScreen: React.FC<HomeScreenProps> = ({ navigation }) => {
        const launchUpswing = () => {
            UpswingModuleEmitter.launchUpswing()
        };

        const launchUpswingViaDeeplink = () => {
            UpswingModuleEmitter.launchUpswingViaDeeplink('upswing-access-partner-acme://?route=support/tickets?source=DEEPLINK'); // this is sample deep link for testing
        };

        const logoutUpswing = () => {
            UpswingModuleEmitter.logoutUpswing();
        };
        return (
            <View style={styles.container}>
                <Button title="Launch Upswing" onPress={launchUpswing} />
                <Button title="Launch Upswing Via Deeplink" onPress={launchUpswingViaDeeplink} />
                <Button title="Logout Upswing" onPress={logoutUpswing} />
            </View>
        );
    };

    const Stack = createStackNavigator<RootStackParamList>();

    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="Home">
                <Stack.Screen name="Home" component={HomeScreen} />
            </Stack.Navigator>
        </NavigationContainer>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
        alignItems: 'center',
        justifyContent: 'center',
    },
    fullscreen: {
        flex: 1,
        width: '100%',
        height: '100%',
        backgroundColor: 'white',
    },
});

export default App;
