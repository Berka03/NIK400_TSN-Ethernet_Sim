import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import inet.node.ethernet.EthernetSwitch;
import ned.DatarateChannel;
import inet.node.tsn.TsnSwitch;
import inet.applications.udpapp.UdpSourceApp;
import inet.applications.udpapp.UdpSink;



channel Eth100M extends DatarateChannel
{
    datarate = 100Mbps;
    delay = 1us;
}

channel Eth1G extends DatarateChannel
{
    datarate = 1 Gbps;
    delay = 1us;
}

network IndustrialCell
{
    parameters:
        @display("bgb=600,500");


    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,50;i=block/cogwheel");
        }

        plc: StandardHost {
            @display("p=400,300;i=device/pc");
        }

        switch: EthernetSwitch {
            @display("p=300,300;i=device/switch");

        }

        sensor1: StandardHost {
            @display("p=200,200;i=device/sensor");
        }

        sensor2: StandardHost {
             @display("p=200,300;i=device/sensor");
        }

        sensor3: StandardHost {
            @display("p=200,400;i=device/sensor");
        }

        actuator1: StandardHost {
            @display("p=300,200;i=device/actuator");
        }

        hmi: StandardHost {
            @display("p=300,400;i=device/tablet");
        }

    connections:
        sensor1.ethg++ <--> Eth100M <--> switch.ethg++;
        sensor2.ethg++ <--> Eth100M <--> switch.ethg++;
        sensor3.ethg++ <--> Eth100M <--> switch.ethg++;
        actuator1.ethg++ <--> Eth100M <--> switch.ethg++;
        hmi.ethg++ <--> Eth100M <--> switch.ethg++;
        plc.ethg++ <--> Eth1G <--> switch.ethg++;
}

