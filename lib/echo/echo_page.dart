import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EchoPage extends StatefulWidget {
  EchoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EchoPage> createState() => _EchoPageState();
}

class _EchoPageState extends State<EchoPage> {

  late WebSocketChannel channel;

  final List<Message> _messages = [];

  final controller = TextEditingController();

  @override
  void initState() {
    channel = WebSocketChannel.connect(
      Uri.parse("wss://ws.postman-echo.com/raw"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echo Webserver"),
      ),
      body: Column(
        children: [
          StreamBuilder<dynamic>(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _messages.add(Message(false, snapshot.data!));
                print("Received new message ${snapshot.data}, message list is ${_messages}");

                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: _messages.map((e) => Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      color: e.fromMe ? Colors.lightGreenAccent : Colors.redAccent,
                      child: Text(e.text),
                    )).toList(),
                  ),
                );
              } else if (snapshot.hasError){
                return Text("Error ${snapshot.error}");
              }

              return const Text("Send some messages");
            }
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Send a message")
                          ),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _messages.add(Message(true, controller.text));
                              });
                              channel.sink.add(controller.text);
                              controller.clear();
                            },
                            child: Text("Send")
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    controller.dispose();
    super.dispose();
  }
}

class Message {
  bool fromMe;
  String text;

  Message(this.fromMe, this.text);

  @override
  String toString() {
    return "Message[fromMe=$fromMe, text=$text]";
  }
}