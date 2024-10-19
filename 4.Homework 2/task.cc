#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/csma-module.h"
#include "ns3/internet-module.h"
#include "ns3/mobility-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/ssid.h"
#include "ns3/yans-wifi-helper.h"
#include "ns3/netanim-module.h"
#include "ns3/point-to-point-layout-module.h"
#include "ns3/wifi-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("Task_1710531");

int
main(int argc, char* argv[]) 
{
    std::string studentId = "non modificato";
    bool tracing = false;
    bool enableRtsCts = false;  

    CommandLine cmd(__FILE__);
    cmd.AddValue("studentId", "Insert student Id", studentId);
    cmd.AddValue("tracing", "Enable pcap tracing", tracing);
    cmd.AddValue("enableRtsCts", "Enable rts/cts", enableRtsCts);

    cmd.Parse(argc, argv);

    if (studentId != "1710531") {
        std::cout << "Parametro studentId non passato o errato!\n";
        return 0;
    }
    if (enableRtsCts) {
        Config::SetDefault("ns3::WifiRemoteStationManager::RtsCtsThreshold", StringValue("500"));
        // è stato scelto 500 per forzare rts/cts nella rete per i pacchetti di strato applicativo
    }  
    if (tracing) {
        std::cout << "Tracing abilitato\n";
    }

    // nodo 4 
    // stella: ptp 4_9, ptp 4_5, ptp 4_2
    uint32_t nSpokes = 3;
    PointToPointHelper pointToPoint;
    pointToPoint.SetDeviceAttribute("DataRate", StringValue("100Mbps"));
    pointToPoint.SetChannelAttribute("Delay", StringValue("20ms"));
    PointToPointStarHelper star(nSpokes, pointToPoint);

    InternetStackHelper internet;
    star.InstallStack(internet);
    
    // point to point 3_4
    uint32_t nPtp = 1;
    NodeContainer nodes3_4;
    nodes3_4.Create(nPtp);
    nodes3_4.Add(star.GetHub());

    PointToPointHelper pointToPoint3_4;
    pointToPoint3_4.SetDeviceAttribute("DataRate", StringValue("10Mbps"));
    pointToPoint3_4.SetChannelAttribute("Delay", StringValue("200ms"));

    NetDeviceContainer ptpdevices3_4;
    ptpdevices3_4 = pointToPoint3_4.Install(nodes3_4);
    internet.Install(nodes3_4.Get(0));

    // nodo 2 
    uint32_t nCsma = 1;
    
    // ethernet csma 2_1 
    NodeContainer csmaNode1;
    csmaNode1.Add(star.GetSpokeNode(0));
    csmaNode1.Create(nCsma); 

    CsmaHelper csma1;
    csma1.SetChannelAttribute("DataRate", StringValue("10Mbps"));
    csma1.SetChannelAttribute("Delay", TimeValue(MicroSeconds(200)));

    NetDeviceContainer csma1Devices;
    csma1Devices = csma1.Install(csmaNode1);
    internet.Install(csmaNode1.Get(1));

    // ethernet csma 2_0 
    NodeContainer csmaNode2;
    csmaNode2.Add(star.GetSpokeNode(0));
    csmaNode2.Create(nCsma); 

    CsmaHelper csma2;
    csma2.SetChannelAttribute("DataRate", StringValue("10Mbps"));
    csma2.SetChannelAttribute("Delay", TimeValue(MicroSeconds(200)));

    NetDeviceContainer csma2Devices;
    csma2Devices = csma2.Install(csmaNode2);
    internet.Install(csmaNode2.Get(1));

    // nodo 5
    // point to point 5_6
    NodeContainer p2pnodes5_6;
    p2pnodes5_6.Add(star.GetSpokeNode(1));
    p2pnodes5_6.Create(1);

    PointToPointHelper pointToPoint5_6;   
    pointToPoint5_6.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    pointToPoint5_6.SetChannelAttribute("Delay", StringValue("20ms"));
 
    NetDeviceContainer ptpdevices5_6; 
    ptpdevices5_6 = pointToPoint5_6.Install(p2pnodes5_6);

    internet.Install(p2pnodes5_6.Get(1));

    // point to point 5_7
    NodeContainer p2pnodes5_7;
    p2pnodes5_7.Add(star.GetSpokeNode(1));
    p2pnodes5_7.Create(1);

    PointToPointHelper pointToPoint5_7;   
    pointToPoint5_7.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    pointToPoint5_7.SetChannelAttribute("Delay", StringValue("20ms"));
 
    NetDeviceContainer ptpdevices5_7; 
    ptpdevices5_7 = pointToPoint5_7.Install(p2pnodes5_7);

    internet.Install(p2pnodes5_7.Get(1));

    // point to point 5_8
    NodeContainer p2pnodes5_8;
    p2pnodes5_8.Add(star.GetSpokeNode(1));
    p2pnodes5_8.Create(1);

    PointToPointHelper pointToPoint5_8;   
    pointToPoint5_8.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    pointToPoint5_8.SetChannelAttribute("Delay", StringValue("20ms"));
 
    NetDeviceContainer ptpdevices5_8; 
    ptpdevices5_8 = pointToPoint5_8.Install(p2pnodes5_8);

    internet.Install(p2pnodes5_8.Get(1));
  
    // nodo 9 (AP)
    // rete wifi (nodi: 10 - 16)
    uint32_t nWifi = 7;
    NodeContainer wifiStaNodes;
    wifiStaNodes.Create(nWifi);
    NodeContainer wifiApNode = star.GetSpokeNode(2);

    YansWifiChannelHelper channel = YansWifiChannelHelper::Default();
    YansWifiPhyHelper phy;
    phy.SetChannel(channel.Create());

    WifiMacHelper mac;
    Ssid ssid = Ssid("1710531");

    WifiHelper wifi;
    wifi.SetStandard(WIFI_STANDARD_80211g);
    wifi.SetRemoteStationManager("ns3::AarfWifiManager");

    NetDeviceContainer staDevices;
    mac.SetType("ns3::StaWifiMac", "Ssid", SsidValue(ssid), "ActiveProbing", BooleanValue(false));
    staDevices = wifi.Install(phy, mac, wifiStaNodes);

    NetDeviceContainer apDevices;
    mac.SetType("ns3::ApWifiMac", "Ssid", SsidValue(ssid));
    apDevices = wifi.Install(phy, mac, wifiApNode);

    MobilityHelper mobility;

    mobility.SetPositionAllocator("ns3::GridPositionAllocator",
                                  "MinX", DoubleValue(0.0),
                                  "MinY", DoubleValue(0.0),
                                  "DeltaX", DoubleValue(4.0),
                                  "DeltaY", DoubleValue(4.0),
                                  "GridWidth", UintegerValue(7),
                                  "LayoutType", StringValue("RowFirst"));

    mobility.SetMobilityModel("ns3::RandomWalk2dMobilityModel",
                              "Bounds",
                              RectangleValue(Rectangle(-30, 30, -30, 30)));
    mobility.Install(wifiStaNodes);

    mobility.SetMobilityModel("ns3::ConstantPositionMobilityModel");
    mobility.Install(wifiApNode);

    internet.Install(wifiStaNodes);
    internet.Install(wifiApNode);

    // Ip Address
    Ipv4AddressHelper address;
    
    address.SetBase("10.1.1.0", "255.255.255.240");
    address.Assign(staDevices);
    address.Assign(apDevices);

    star.AssignIpv4Addresses(Ipv4AddressHelper("191.168.0.0", "255.255.255.248"));

    address.SetBase("10.1.2.0", "255.255.255.252");
    Ipv4InterfaceContainer ptp5_6Interface;
    ptp5_6Interface = address.Assign(ptpdevices5_6);

    address.SetBase("10.1.2.4", "255.255.255.252");
    Ipv4InterfaceContainer ptp5_7Interface;
    ptp5_7Interface = address.Assign(ptpdevices5_7);

    address.SetBase("10.1.2.8", "255.255.255.252");
    Ipv4InterfaceContainer ptp5_8Interface;
    ptp5_8Interface = address.Assign(ptpdevices5_8);

    address.SetBase("195.130.67.0", "255.255.255.252");
    Ipv4InterfaceContainer ptp3_4Interface;
    ptp3_4Interface = address.Assign(ptpdevices3_4);

    address.SetBase("10.1.3.0", "255.255.255.252");
    Ipv4InterfaceContainer csma1Interface;
    csma1Interface = address.Assign(csma1Devices);
    
    address.SetBase("10.1.3.4", "255.255.255.252");
    Ipv4InterfaceContainer csma2Interface;
    csma2Interface = address.Assign(csma2Devices);
    
    // UdpEcho application with Client 6 and Server 3
    // size of packet: 1724 Byte     Periodicity: 20ms       Max Packets: 250
    u_int32_t porta1 = 9;
    UdpEchoServerHelper echoServer(porta1);

    ApplicationContainer serverApps = echoServer.Install(nodes3_4.Get(0));
    serverApps.Start(Seconds(1.0));
    serverApps.Stop(Seconds(10.0));

    UdpEchoClientHelper echoClient(ptp3_4Interface.GetAddress(0), porta1);
    echoClient.SetAttribute("MaxPackets", UintegerValue(250));
    echoClient.SetAttribute("Interval", TimeValue(MilliSeconds(20)));
    echoClient.SetAttribute("PacketSize", UintegerValue(1724));

    ApplicationContainer clientApps = echoClient.Install(p2pnodes5_6.Get(1));
    clientApps.Start(Seconds(2.0));
    clientApps.Stop(Seconds(10.0));

    echoClient.SetFill(clientApps.Get(0), "Benedetta, Fiorillo, 1710531, Simone, Giudici, 1985466, Jacopo, Brischetto, 2014105, Andrea, Di Vito, 1997459, Nicola, Di Francesco, 2007404");

    // TCP burst traffic of 1117 Byte for each packet starting at 0.25s
    // Sender: nodo 14, Server: nodo 0
    u_int32_t porta2 = 1125;
    OnOffHelper onOffHelper1("ns3::TcpSocketFactory", InetSocketAddress(csma2Interface.GetAddress(1), porta2));
    onOffHelper1.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper1.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper1.SetAttribute("PacketSize", UintegerValue(1117));

    ApplicationContainer onOffApp1 = onOffHelper1.Install(wifiStaNodes.Get(4));     // nodo 14 = wifiStaNodes[4]
    onOffApp1.Start(Seconds(0.25));
    onOffApp1.Stop(Seconds(10.0));

    PacketSinkHelper packetSinkHelper1("ns3::TcpSocketFactory", InetSocketAddress(Ipv4Address::GetAny(), porta2));
    ApplicationContainer sinkApp1 = packetSinkHelper1.Install(csmaNode2.Get(1));
    sinkApp1.Start(Seconds(0.0));
    sinkApp1.Stop(Seconds(10.0));
    
    // TCP burst traffic of 1369 Byte for each packet starting at 3.80s
    // Sender: nodo 8, Server: nodo 1
    u_int32_t porta3 = 1123;
    OnOffHelper onOffHelper2("ns3::TcpSocketFactory", InetSocketAddress(csma1Interface.GetAddress(1), porta3));
    onOffHelper2.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper2.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper2.SetAttribute("PacketSize", UintegerValue(1369));

    ApplicationContainer onOffApp2 = onOffHelper2.Install(p2pnodes5_8.Get(1));
    onOffApp2.Start(Seconds(3.80));
    onOffApp2.Stop(Seconds(10.0));

    PacketSinkHelper packetSinkHelper2("ns3::TcpSocketFactory", InetSocketAddress(Ipv4Address::GetAny(), porta3));
    ApplicationContainer sinkApp2 = packetSinkHelper2.Install(csmaNode1.Get(1));
    sinkApp2.Start(Seconds(0.0));
    sinkApp2.Stop(Seconds(10.0));

    // TCP burst traffic of 1745 Byte for each packet starting at 3.97s
    // Sender: nodo 10, Server: nodo 0
    u_int32_t porta4 = 1127;
    OnOffHelper onOffHelper3("ns3::TcpSocketFactory", InetSocketAddress(csma2Interface.GetAddress(1), porta4));
    onOffHelper3.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper3.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    onOffHelper3.SetAttribute("PacketSize", UintegerValue(1745));

    ApplicationContainer onOffApp3 = onOffHelper3.Install(wifiStaNodes.Get(0));     // nodo 10 = wifiStaNodes[0]
    onOffApp3.Start(Seconds(3.97));
    onOffApp3.Stop(Seconds(10.0));

    PacketSinkHelper packetSinkHelper3("ns3::TcpSocketFactory", InetSocketAddress(Ipv4Address::GetAny(), porta4));
    ApplicationContainer sinkApp3 = packetSinkHelper3.Install(csmaNode2.Get(1));
    sinkApp3.Start(Seconds(0.0));
    sinkApp3.Stop(Seconds(10.0));
     
    if (tracing) {
        phy.SetPcapDataLinkType(WifiPhyHelper::DLT_IEEE802_11_RADIO);
                               
        pointToPoint.EnablePcap("task-4", star.GetHub()->GetDevice(0), true);               // nodo 4 
        pointToPoint.EnablePcap("task-4", star.GetHub()->GetDevice(1), true);               // nodo 4
        pointToPoint.EnablePcap("task-4", star.GetHub()->GetDevice(2), true);               // nodo 4
        pointToPoint3_4.EnablePcap("task-4.pcap", ptpdevices3_4.Get(1), true, true);        // nodo 4
        
        pointToPoint.EnablePcap("task-2.pcap", star.GetSpokeNode(0)->GetDevice(0), true, true);    // nodo 2
        pointToPoint.EnablePcap("task-5.pcap", star.GetSpokeNode(1)->GetDevice(0), true, true);    // nodo 5
        phy.EnablePcap("task-9.pcap", apDevices.Get(0), true, true);                               // nodo 9
    }

    Ipv4GlobalRoutingHelper::PopulateRoutingTables();

    Simulator::Stop(Seconds(15.0));
   
    Simulator::Run();
    Simulator::Destroy();
    return 0;
}