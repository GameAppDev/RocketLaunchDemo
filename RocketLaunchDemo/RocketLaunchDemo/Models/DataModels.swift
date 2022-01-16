//
// DataModels.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import Foundation

struct LaunchResponse:Codable {
    let flight_number:Int?
    let mission_name:String?
    let mission_id:[String]?
    //let upcoming:Int?//Bool?
    //let launch_year:Int?
    //let launch_date_unix:Float?
    //let launch_date_utc:String?
    //let is_tentative:Int?//Bool?
    //let tentative_max_precision:String?
    //let tbd:Int? //Bool?
    //let launch_window:Int?
    //let rocket:Rocket??
    //let ships:[String]?
    //let telemetry:Telemetry?
    //let launch_site:LaunchSite?
    //let launch_success:Int?//Bool?
    //let launch_failure_details:LaunchFailureDetails?
    //let links:Links?
    let details:String?
    //let static_fire_date_utc:String?
    //let static_fire_date_unix:Float?
    //let timeline:Timeline?
}

struct Rocket:Codable {
    let rocket_id:String?
    let rocket_name:String?
    let rocket_type:String?
    let first_stage:FirstStage?
    let second_stage:SecondStage?
    let fairings:Fairings?
}

struct FirstStage:Codable {
    let cores:[Cores]?
}

struct Cores:Codable {
    let core_serial:String?
    let flight:Int?
    let block:Int?
    let gridfins:Int?//Bool?
    let legs:Int?//Bool?
    let reused:Int?//Bool?
    let land_success:Int?//Bool?
    let landing_intent:Int?//Bool?
    let landing_type:String?
    let landing_vehicle:String?
}

struct SecondStage:Codable {
    let block:Int?
    let payloads:[Payloads]?
}

struct Payloads:Codable {
    let payload_id:String?
    let norad_id:[Int]?
    let reused:Int?//Bool?
    let customers:[String]?
    let nationality:String?
    let manufacturer:String?
    let payload_type:String?
    let payload_mass_kg:Float?
    let payload_mass_lbs:Float?
    let orbit:String?
    let orbit_params:OrbitParams?
}

struct OrbitParams:Codable {
    let reference_system:String?
    let regime:String?
    let longitude:Float?
    let semi_major_axis_km:Float?
    let eccentricity:Float?
    let periapsis_km:Float?
    let apoapsis_km:Float?
    let inclination_deg:Float?
    let period_min:Float?
    let lifespan_years:Int?
    let epoch:String?
    let mean_motion:Float?
    let raan:Float?
    let arg_of_pericenter:Float?
    let mean_anomaly:Float?
}

struct Fairings:Codable {
    let reused:Int?//Bool?
    let recovery_attempt:Int?//Bool?
    let recovered:Int?//Bool?
    let ship:String?
}

struct Telemetry:Codable {
    let flight_club:String?
}

struct LaunchSite:Codable {
    let site_id:String?
    let site_name:String?
    let site_name_long:String?
}

struct LaunchFailureDetails:Codable {
    let time:Int?
    let altitude:Int?
    let reason:String?
}

struct Links:Codable {
    let mission_patch:String?
    let mission_patch_small:String?
    let reddit_campaign:String?
    let reddit_launch:String?
    let reddit_recovery:String?
    let reddit_media:String?
    let presskit:String?
    let article_link:String?
    let wikipedia:String?
    let video_link:String?
    let youtube_id:String?
    let flickr_images:[String]?
}

struct Timeline:Codable {
    let webcast_liftoff:Int?
}
