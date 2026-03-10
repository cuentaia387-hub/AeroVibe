Place Nunito font files here:

- Nunito-Light.ttf        (weight 300)
- Nunito-Regular.ttf      (weight 400)
- Nunito-SemiBold.ttf     (weight 600)
- Nunito-Bold.ttf         (weight 700)
- Nunito-ExtraBold.ttf    (weight 800)

Download from: https://fonts.google.com/specimen/Nunito

NOTE: The app uses google_fonts package as a fallback if these files 
are not present. The fonts will be downloaded automatically at runtime
when using the google_fonts package. However, for offline APK builds,
you should include the font files here.

To bundle fonts offline in the APK, just place the .ttf files in this
directory and run: flutter pub get
