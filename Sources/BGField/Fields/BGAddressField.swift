//
//  BGAddressField.swift
//  BGField
//
//  Created by Basem's Dawarha Macbook on 12/02/2025.
//

// BGField.swift
// Refactored BGAddressField to Auto-fetch User Location and Allow Manual Entry

import SwiftUI
import MapKit
import CoreLocation

// MARK: - Identifiable Location Model

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

// MARK: - BGAddressField

public struct BGAddressField: View {
    @Binding var text: String
    var placeholder: LocalizedStringResource
    var config: BGFieldConfig
    var onSubmit: (() -> Void)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @StateObject private var locationManager = LocationManager()
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                TextField("",
                          text: $text,
                          prompt: Text(placeholder).foregroundColor(config.text.placeholderColor).font(config.text.font))
                    .textContentType(.fullStreetAddress)
                
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        locationManager.requestLocationPermission()
                        locationManager.requestLocation()
                    }
            }
        }
        .onReceive(locationManager.$lastKnownLocation) { location in
            guard let location = location else { return }
            reverseGeocode(location: location)
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let address = [
                    placemark.name,
                    placemark.thoroughfare,
                    placemark.subThoroughfare,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.postalCode,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
                DispatchQueue.main.async {
                    text = address
                    onSubmit()
                }
            }
        }
    }
}

// MARK: - Location Manager

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocationPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        } else {
            print("Location permission not granted.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
