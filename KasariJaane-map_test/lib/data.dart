{
    "vehicles": [
        {
            "id": 1,
            "name": "Sajha Bus",
            "type": "bus",
            "routes": [
                {
                    "id": 1,
                    "name": "S1",
                    "starting_point": "A",
                    "final_point": "F",
                    "vehicle": 1,
                    "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "fares": [
                        {
                            "id": 1,
                            "start_location": "A",
                            "end_location": "B",
                            "fare": "5.00",
                            "route": 1
                        },
                        {
                            "id": 2,
                            "start_location": "A",
                            "end_location": "C",
                            "fare": "10.00",
                            "route": 1
                        },
                        {
                            "id": 3,
                            "start_location": "A",
                            "end_location": "D",
                            "fare": "15.00",
                            "route": 1
                        },
                        {
                            "id": 4,
                            "start_location": "A",
                            "end_location": "E",
                            "fare": "20.00",
                            "route": 1
                        },
                        {
                            "id": 5,
                            "start_location": "A",
                            "end_location": "F",
                            "fare": "25.00",
                            "route": 1
                        },
                        {
                            "id": 7,
                            "start_location": "B",
                            "end_location": "C",
                            "fare": "5.00",
                            "route": 1
                        },
                        {
                            "id": 8,
                            "start_location": "B",
                            "end_location": "D",
                            "fare": "10.00",
                            "route": 1
                        },
                        {
                            "id": 9,
                            "start_location": "B",
                            "end_location": "D",
                            "fare": "10.00",
                            "route": 1
                        },
                        {
                            "id": 10,
                            "start_location": "B",
                            "end_location": "E",
                            "fare": "15.00",
                            "route": 1
                        },
                        {
                            "id": 11,
                            "start_location": "B",
                            "end_location": "E",
                            "fare": "20.00",
                            "route": 1
                        },
                        {
                            "id": 12,
                            "start_location": "C",
                            "end_location": "D",
                            "fare": "5.00",
                            "route": 1
                        },
                        {
                            "id": 13,
                            "start_location": "C",
                            "end_location": "E",
                            "fare": "10.00",
                            "route": 1
                        },
                        {
                            "id": 14,
                            "start_location": "C",
                            "end_location": "F",
                            "fare": "15.00",
                            "route": 1
                        },
                        {
                            "id": 15,
                            "start_location": "D",
                            "end_location": "E",
                            "fare": "5.00",
                            "route": 1
                        },
                        {
                            "id": 16,
                            "start_location": "D",
                            "end_location": "F",
                            "fare": "10.00",
                            "route": 1
                        },
                        {
                            "id": 17,
                            "start_location": "E",
                            "end_location": "F",
                            "fare": "5.00",
                            "route": 1
                        }
                    ]
                },
                {
                    "id": 2,
                    "name": "S2",
                    "starting_point": "G",
                    "final_point": "L",
                    "vehicle": 1,
                    "stops": [],
                    "fares": [
                        {
                            "id": 21,
                            "start_location": "sukedhara",
                            "end_location": "chappakkarkhana",
                            "fare": "15.00",
                            "route": 2
                        }
                    ]
                }
            ]
        },
        {
            "id": 2,
            "name": "Tempo",
            "type": "tempo",
            "routes": [
                {
                    "id": 5,
                    "name": "tempo-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                    "vehicle": 2,
                    "stops": [],
                    "fares": [
                        {
                            "id": 23,
                            "start_location": "sukedhara",
                            "end_location": "chappakkarkhana",
                            "fare": "15.00",
                            "route": 5
                        }
                    ]
                }
            ]
        },
        {
            "id": 3,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 6,
                    "name": "nepalyatayat-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                    "vehicle": 3,
                    "stops": [],
                    "fares": []
                }
            ]
        },
        {
            "id": 4,
            "name": "Micro Bus",
            "type": "microbus",
            "routes": [
                {
                    "id": 4,
                    "name": "micro-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                    "vehicle": 4,
                    "stops": [],
                    "fares": [
                        {
                            "id": 22,
                            "start_location": "sukedhara",
                            "end_location": "chappakkarkhana",
                            "fare": "15.00",
                            "route": 4
                        }
                    ]
                }
            ]
        },
        {
            "id": 5,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 3,
                    "name": "route1",
                    "starting_point": "balkumari",
                    "final_point": "sukedhara",
                    "vehicle": 5,
                    "stops": [],
                    "fares": [
                        {
                            "id": 18,
                            "start_location": "sukedhara",
                            "end_location": "dhumbarahi",
                            "fare": "15.00",
                            "route": 3
                        },
                        {
                            "id": 19,
                            "start_location": "sukedhara",
                            "end_location": "chappakkarkhana",
                            "fare": "15.00",
                            "route": 3
                        },
                        {
                            "id": 20,
                            "start_location": "sukedhara",
                            "end_location": "dhumbarahi",
                            "fare": "15.00",
                            "route": 3
                        }
                    ]
                }
            ]
        }
    ]
}