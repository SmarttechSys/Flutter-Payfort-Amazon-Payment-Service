package com.vvvirani.amazon_payfort

import android.content.Context

import androidx.annotation.NonNull
import com.payfort.fortpaymentsdk.FortSdk
import com.payfort.fortpaymentsdk.domain.model.FortRequest

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.HashMap

class AmazonPayfortPlugin : FlutterPlugin,
    MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private lateinit var binding: ActivityPluginBinding

    private var fortRequest = FortRequest()
    private var service: PayFortService? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger,
            "vvvirani/amazon_payfort")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                if (service == null) {
                    service = PayFortService()
                    service?.initService()
                    binding.addActivityResultListener { requestCode, resultCode, data ->
                        service?.onActivityResult(requestCode, resultCode, data)
                        true
                    }

                }
            }
            "getEnvironmentBaseUrl" -> {
                val envType = call.argument<String>("envType")
                val environment = envType?.let { service?.getEnvironmentBaseUrl(it) }
                result.success(environment)
            }
            "getDeviceId" -> {
                val deviceId = FortSdk.getDeviceId(binding.activity)
                result.success(deviceId)
            }
            "generateSignature" -> {
                val shaType = call.argument<String>("shaType")
                val concatenatedString = call.argument<String>("concatenatedString")
                val signature =
                    shaType?.let {
                        concatenatedString?.let { it1 ->
                            service?.createSignature(it,
                                it1)
                        }
                    }
                result.success(signature)
            }
            "callPayFort" -> {
                val envType = call.argument<String>("envType")

                fortRequest.requestMap = createRequestMap(call)
                fortRequest.isShowResponsePage = true

                service?.callPayFort(
                    binding.activity,
                    envType,
                    fortRequest,
                    object : PayFortService.PayFortResultHandler {
                        override fun onResult(fortResult: MutableMap<String, Any>?) {
                            result.success(fortResult)
                        }
                    }
                )
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun createRequestMap(call: MethodCall): MutableMap<String, Any?> {
        val requestMap: MutableMap<String, Any?> = HashMap()
        requestMap["sdkToken"] = call.argument<String>("sdkToken")
        requestMap["merchantRef"] = call.argument<String>("merchantRef")
        requestMap["lang"] = call.argument<String>("lang")
        requestMap["command"] = call.argument<String>("command")
        requestMap["amount"] = call.argument<String>("amount")
        requestMap["email"] = call.argument<String>("email")
        requestMap["currency"] = call.argument<String>("currency")
        requestMap["merchant_extra"] = call.argument<String>("merchant_extra")
        requestMap["merchant_extra1"] = call.argument<String>("merchant_extra1")
        requestMap["payment_option"] = call.argument<String>("payment_option")
        return requestMap
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.binding = binding
    }

    override fun onDetachedFromActivity() {
    }
}