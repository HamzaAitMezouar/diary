//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import connectivity_plus
import facebook_auth_desktop
<<<<<<< HEAD
<<<<<<< HEAD
import firebase_auth
import firebase_core
import flutter_local_notifications
=======
>>>>>>> c372a4f (add notifier and fix sp)
import flutter_secure_storage_macos
import geolocator_apple
=======
import firebase_auth
import firebase_core
import flutter_secure_storage_macos
>>>>>>> beffd0f (add gogle and facebook auth and articles)
import google_sign_in_ios
import path_provider_foundation
import shared_preferences_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ConnectivityPlusPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlusPlugin"))
  FacebookAuthDesktopPlugin.register(with: registry.registrar(forPlugin: "FacebookAuthDesktopPlugin"))
<<<<<<< HEAD
<<<<<<< HEAD
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FlutterLocalNotificationsPlugin.register(with: registry.registrar(forPlugin: "FlutterLocalNotificationsPlugin"))
=======
>>>>>>> c372a4f (add notifier and fix sp)
  FlutterSecureStoragePlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStoragePlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
=======
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FlutterSecureStoragePlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStoragePlugin"))
>>>>>>> beffd0f (add gogle and facebook auth and articles)
  FLTGoogleSignInPlugin.register(with: registry.registrar(forPlugin: "FLTGoogleSignInPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
}
