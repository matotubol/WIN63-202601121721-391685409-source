package com.sulake.habbo.phonenumber
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class VerificationCodeInputView
   {
      
      private static const INPUT_MAX_CHARS:int = 10;
      
      private var var_59:HabboPhoneNumber;
      
      private var _window:class_2250;
      
      private var _inputTextNeedsClearing:Boolean = true;
      
      private var var_832:Timer;
      
      public function VerificationCodeInputView(param1:HabboPhoneNumber)
      {
         super();
         var_59 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_832)
         {
            var_832.reset();
            var_832 = null;
         }
         var_59 = null;
      }
      
      public function handleSubmitFailure(param1:int) : void
      {
         var_59.windowManager.alert("${generic.alert.title}","${phone.number.verify.error." + param1 + "}",0,null);
         ITextFieldWindow(_window.findChildByName("verification_code_input")).textColor = 16711680;
         _window.findChildByName("verification_code_input").enable();
         _inputTextNeedsClearing = true;
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            return;
         }
         _window = class_2250(var_59.windowManager.buildFromXML(XML(var_59.assets.getAssetByName("phonenumber_verify_xml").content)));
         _window.center();
         if(_window.findChildByName("wait_link"))
         {
            _window.findChildByName("wait_link").procedure = onInputButtons;
         }
         _window.findChildByName("ok_button").procedure = onInputButtons;
         if(_window.findChildByName("header_button_close"))
         {
            _window.findChildByName("header_button_close").visible = false;
         }
         _window.findChildByName("verification_code_input").procedure = onInputButtons;
         _window.findChildByName("did_not_receive_code_link").procedure = onInputButtons;
         _window.findChildByName("ok_button").disable();
         _window.findChildByName("verification_code_input").enable();
         if(var_59.retryEnableTime - getTimer() <= 0)
         {
            showRetry();
         }
         else
         {
            showWaitForRetry();
         }
         ITextFieldWindow(_window.findChildByName("verification_code_input")).maxChars = 10;
         _inputTextNeedsClearing = true;
      }
      
      private function onInputButtons(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "wait_link":
               var_59.setVerifyViewMinimized(true);
               break;
            case "did_not_receive_code_link":
               var_59.requestPhoneNumberCollectionReset();
               break;
            case "ok_button":
               var_59.sendTryVerificationCode(_window.findChildByName("verification_code_input").caption);
               _window.findChildByName("ok_button").disable();
               _window.findChildByName("verification_code_input").disable();
               break;
            case "verification_code_input":
               if(_inputTextNeedsClearing)
               {
                  _window.findChildByName("verification_code_input").caption = "";
                  _inputTextNeedsClearing = false;
               }
               _window.findChildByName("ok_button").enable();
               ITextFieldWindow(_window.findChildByName("verification_code_input")).textColor = 0;
         }
      }
      
      public function showRetry() : void
      {
         _window.findChildByName("did_not_receive_code_link").visible = true;
         _window.findChildByName("retry_wait_label").visible = false;
      }
      
      public function showWaitForRetry(param1:int = 0) : void
      {
         _window.findChildByName("did_not_receive_code_link").visible = false;
         _window.findChildByName("retry_wait_label").visible = true;
         onWaitTimer();
         var_832 = new Timer(1000);
         var_832.addEventListener("timer",onWaitTimer);
         var_832.start();
      }
      
      private function onWaitTimer(param1:TimerEvent = null) : void
      {
         var _loc3_:String = var_59.localizationManager.getLocalization("phone.number.verify.wait.remaining","");
         var _loc2_:int = Math.max(0,(var_59.retryEnableTime - getTimer()) / 1000);
         _loc3_ = _loc3_.replace("{0}",_loc2_);
         (_window.findChildByName("retry_wait_label") as ILabelWindow).text = _loc3_;
         if(_loc2_ == 0)
         {
            if(var_832)
            {
               var_832.stop();
            }
            var_832 = null;
            showRetry();
         }
      }
   }
}

