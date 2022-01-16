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
    let launch_date_utc:String?
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
    let links:Links?
    let details:String?
    //let static_fire_date_utc:String?
    //let static_fire_date_unix:Float?
    //let timeline:Timeline?
}
/*
 {
    "flight_number": 75,
    "mission_name": "Nusantara Satu (PSN-6) / GTO-1 / Beresheet",
    "mission_id": [],
    "launch_year": "2019",
    "launch_date_unix": 1550799900,
    "launch_date_utc": "2019-02-22T01:45:00.000Z",
    "launch_date_local": "2019-02-21T20:45:00-05:00",
    "is_tentative": false,
    "tentative_max_precision": "hour",
    "tbd": false,
    "launch_window": null,
    "rocket": {
      "rocket_id": "falcon9",
      "rocket_name": "Falcon 9",
      "rocket_type": "FT",
      "first_stage": {
        "cores": [
          {
            "core_serial": "B1048",
            "flight": 3,
            "block": 5,
            "gridfins": true,
            "legs": true,
            "reused": true,
            "land_success": null,
            "landing_intent": true,
            "landing_type": "ASDS",
            "landing_vehicle": "OCISLY"
          }
        ]
      },
      "second_stage": {
        "block": 5,
        "payloads": [
          {
            "payload_id": "Nusantara Satu (PSN-6)",
            "norad_id": [],
            "reused": false,
            "customers": [
              "Pasifik Satelit Nusantara"
            ],
            "nationality": "Indonesia",
            "manufacturer": "SSL",
            "payload_type": "Satellite",
            "payload_mass_kg": 5000,
            "payload_mass_lbs": 11023.11,
            "orbit": "GTO",
            "orbit_params": {
              "reference_system": null,
              "regime": null,
              "longitude": null,
              "semi_major_axis_km": null,
              "eccentricity": null,
              "periapsis_km": null,
              "apoapsis_km": null,
              "inclination_deg": null,
              "period_min": null,
              "lifespan_years": 15,
              "epoch": null,
              "mean_motion": null,
              "raan": null,
              "arg_of_pericenter": null,
              "mean_anomaly": null
            }
          },
          {
            "payload_id": "GTO-1",
            "norad_id": [],
            "reused": false,
            "customers": [
              "Spaceflight Industries, Inc"
            ],
            "nationality": "United States",
            "manufacturer": null,
            "payload_type": "Unknown",
            "payload_mass_kg": null,
            "payload_mass_lbs": null,
            "orbit": "GTO",
            "orbit_params": {
              "reference_system": "geocentric",
              "regime": "geostationary",
              "longitude": null,
              "semi_major_axis_km": null,
              "eccentricity": null,
              "periapsis_km": null,
              "apoapsis_km": null,
              "inclination_deg": null,
              "period_min": null,
              "lifespan_years": null,
              "epoch": null,
              "mean_motion": null,
              "raan": null,
              "arg_of_pericenter": null,
              "mean_anomaly": null
            }
          },
          {
            "payload_id": "Beresheet",
            "norad_id": [],
            "reused": false,
            "customers": [
              "SpaceIL"
            ],
            "nationality": "Israel",
            "manufacturer": "SSL",
            "payload_type": "Lander",
            "payload_mass_kg": 585,
            "payload_mass_lbs": 1289.7,
            "orbit": "GTO",
            "orbit_params": {
              "reference_system": null,
              "regime": null,
              "longitude": null,
              "semi_major_axis_km": null,
              "eccentricity": null,
              "periapsis_km": null,
              "apoapsis_km": null,
              "inclination_deg": null,
              "period_min": null,
              "lifespan_years": 0.00547945,
              "epoch": null,
              "mean_motion": null,
              "raan": null,
              "arg_of_pericenter": null,
              "mean_anomaly": null
            }
          }
        ]
      },
      "fairings": {
        "reused": false,
        "recovery_attempt": false,
        "recovered": false,
        "ship": null
      }
    },
    "ships": [],
    "telemetry": {
      "flight_club": null
    },
    "launch_site": {
      "site_id": "ccafs_slc_40",
      "site_name": "CCAFS SLC 40",
      "site_name_long": "Cape Canaveral Air Force Station Space Launch Complex 40"
    },
    "launch_success": null,
    "links": {
      "mission_patch": null,
      "mission_patch_small": null,
      "reddit_campaign": "https://www.reddit.com/r/spacex/comments/afxyrd/nusantara_satu_launch_campaign_thread/",
      "reddit_launch": null,
      "reddit_recovery": null,
      "reddit_media": null,
      "presskit": null,
      "article_link": null,
      "wikipedia": null,
      "video_link": null,
      "youtube_id": null,
      "flickr_images": []
    },
    "details": null,
    "upcoming": true,
    "static_fire_date_utc": null,
    "static_fire_date_unix": null,
    "timeline": null
  }
 */
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

struct LaunchUpcomingResponse:Codable {
    let mission_name:String?
    //let launch_site:LaunchSite?
    //let tentative_max_precision:String?
    //let timeline:Timeline?
    let links:Links?
    //let last_wiki_launch_date:String?
}
