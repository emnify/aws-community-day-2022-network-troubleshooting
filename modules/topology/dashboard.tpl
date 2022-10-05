{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsIn", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "eu-west-1",
                "period": 300,
                "title": "Left In"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 6,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsOut", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "eu-west-1",
                "period": 300,
                "title": "Left Out"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "PacketDropCountBlackhole", "TransitGatewayAttachment", "${tgw_attach_left}", "TransitGateway", "${tgw_id}" ],
                    [ ".", "PacketDropCountNoRoute", ".", ".", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "eu-west-1",
                "period": 300,
                "title": "Left Drops"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsIn", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "eu-west-1",
                "period": 300,
                "title": "Right In"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 6,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/TransitGateway", "PacketsOut", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ]
                ],
                "region": "eu-west-1",
                "period": 300,
                "title": "Right Out"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 12,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/TransitGateway", "PacketDropCountBlackhole", "TransitGatewayAttachment", "${tgw_attach_right}", "TransitGateway", "${tgw_id}" ],
                    [ ".", "PacketDropCountNoRoute", ".", ".", ".", "." ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "eu-west-1",
                "period": 300,
                "title": "Right Drops"
            }
        }
    ]
}