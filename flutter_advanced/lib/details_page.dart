import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'place_details_model.dart';

class PlaceDetailsPage extends StatelessWidget {
  var screenWidth;
  PlaceDetails placeDetails;

  PlaceDetailsPage(this.placeDetails);

  _buildSettingElement(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blueAccent,
          size: 22,
        ),
        Text(text.toUpperCase())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Flexible(
          child: _buildPlaceImage(),
          flex: 1,
        ),
        Flexible(
            child: Column(
              children: [
                _buildPlaceDescriptopnAndRating(),
                _buildUserActions(),
                _buildTestButton()
              ],
            ),
            flex: 2),
      ],
    );
  }

  _buildPlaceImage() {
    return Container(
      width: screenWidth,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Image.network(placeDetails.imageUrl),
      ),
    );
  }

  _buildPlaceDescriptopnAndRating() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeDetails.name,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  placeDetails.city,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            )),
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text(placeDetails.stars.toString())
          ],
        ),
      ),
    );
  }

  _buildCallButton() {
    Widget call = _buildSettingElement(Icons.call, "Call");
    return InkWell(
      child: call,
      onTap: () {
        _call();
      },
    );
  }

  _buildMessageButton() {
    Widget message = _buildSettingElement(Icons.message, "Message");
    return InkWell(
      child: message,
      onTap: () {
        print("Message Clicked");
      },
    );
  }

  _buildShareButton() {
    Widget share = _buildSettingElement(Icons.share, "Share");
    return InkWell(
      child: share,
      onTap: () {
        print("Share Clicked");
      },
    );
  }

  _buildUserActions() {
    Widget call = _buildCallButton();
    Widget message = _buildMessageButton();
    Widget share = _buildShareButton();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [call, message, share],
    );
  }

  _buildTestButton() {
    return RaisedButton(
      child: Text("Say Hello"),
      onPressed: () {
        print('Hello');
      },
    );
  }

  _call() async {
    var url = 'tel:' + placeDetails.phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
