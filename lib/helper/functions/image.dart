/// Here's how the cloudinary image url is returned from the server:
///"image/upload/https://res.cloudinary.com/dvghxq3ba/image/upload/v1704645477/News%20Cover%20Pics/waaji4nx4cufwsq1sxsw.jpg"
///This function extracts the image url from the cloudinary image url.
///The image url starts from https.
String extractImageUrl(String cloudinaryImageUrl) {
  return cloudinaryImageUrl.split('upload/')[1];
}