package twochealthcare.io
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private var startString: String? = null
    private var path: List<String>? = null
    private val deepLinkChannel = "deeplink_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, deepLinkChannel).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (!path.isNullOrEmpty()) {
                    // Toast.makeText(applicationContext,"initialLink call  "+path.toString(), Toast.LENGTH_SHORT).show()
                    result.success(path)
                }else{
                    result.success(null)
                }
            }
        }
    }

   override fun onCreate(savedInstanceState: Bundle?) {
       // Aligns the Flutter view vertically with the window.
    //    WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

    //    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
    //        // Disable the Android splash screen fade out animation to avoid
    //        // a flicker before the similar frame is drawn in Flutter.
    //        splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
    //    }
        super.onCreate(savedInstanceState)

       var intent : Intent? = getIntent()

       val uri : Uri? = intent?.data;
    //    Toast.makeText(applicationContext,"onCreate path not set "+path.toString(), Toast.LENGTH_SHORT).show()
       path  = uri?.pathSegments
    //    Toast.makeText(applicationContext,"onCreate path set "+path.toString(), Toast.LENGTH_SHORT).show()
       if (!path.isNullOrEmpty()) {
           intent = null
       }

   }
//
//    override fun onResume() {
//        super.onResume()
//        var intent : Intent? = getIntent()
//
//        val uri : Uri? = intent?.data;
//
//        val path : List<String>? = uri?.pathSegments
//
//        if (!path.isNullOrEmpty()) {
//            val lastPathSegment: String = path.last()
//
//            // Now, lastPathSegment contains the parameter you want (e.g., "electronics")
//            // You can use it as needed in your activity
//
//            startString = lastPathSegment;
//
//            Toast.makeText(applicationContext,"onResume "+startString, Toast.LENGTH_SHORT).show()
//
//            intent = null
//        }
//    }



}
