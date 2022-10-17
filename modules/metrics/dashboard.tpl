{
    "widgets": [
        {
            "height": 5,
            "width": 8,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsIn", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "${region}",
                "period": 300,
                "title": "Left In",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": true
                     }
                }
            }
        },

        {
            "height": 5,
            "width": 8,
            "y": 0,
            "x": 8,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsOut", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "${region}",
                "period": 300,
                "title": "Right Out",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": true
                     }
                }
            }
        },
        {
            "height": 5,
            "width": 8,
            "y": 0,
            "x": 16,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "PacketDropCountBlackhole", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ],
                    [ ".", "PacketDropCountNoRoute", ".", ".", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${region}",
                "period": 300,
                "title": "Left Drops",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": true
                    }
                 }
            }
        },
        {
            "height": 5,
            "width": 8,
            "y": 5,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsIn", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "${region}",
                "period": 300,
                "title": "Right In",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                   },
                   "right": {
                       "showUnits": true
                    }
                }
            }
        },
        {
            "height": 5,
            "width": 8,
            "y": 5,
            "x": 8,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsOut", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "${region}",
                "period": 300,
                "title": "Left Out",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": true
                    }
                }
            }
        },
        {
            "height": 5,
            "width": 8,
            "y": 5,
            "x": 16,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "PacketDropCountBlackhole", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ],
                    [ ".", "PacketDropCountNoRoute", ".", ".", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${region}",
                "period": 300,
                "title": "Right Drops",
                "yAxis": {
                    "left": {
                        "label": "",
                        "min": 0,
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": true
                    }
                }
            }
        }
    ]
}