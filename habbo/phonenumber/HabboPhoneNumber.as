package com.sulake.habbo.phonenumber
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.VerifyCodeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.TryPhoneNumberMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryVerificationCodeResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryPhoneNumberResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.PhoneCollectionStateMessageEvent;
   
   public class HabboPhoneNumber extends class_17
   {
      
      protected var _communicationManager:class_57;
      
      protected var _localizationManager:class_27;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _toolbar:IHabboToolbar;
      
      protected var _windowManager:class_38;
      
      private var var_37:IConnection;
      
      private var var_1723:PhoneNumberCollectView;
      
      private var var_1379:PhoneNumberCollectMinimizedView;
      
      private var var_1693:VerificationCodeInputView;
      
      private var var_1388:VerificationCodeInputMinimizedView;
      
      private var _retryEnableTime:int;
      
      public function HabboPhoneNumber(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(getBoolean("sms.identity.verification.enabled"))
         {
            var_37 = _communicationManager.connection;
            var_37.addMessageEvent(new PhoneCollectionStateMessageEvent(onStateMessage));
            var_37.addMessageEvent(new TryPhoneNumberResultMessageEvent(onPhoneNumberResultMessage));
            var_37.addMessageEvent(new TryVerificationCodeResultMessageEvent(onVerificationCodeResultMessage));
         }
      }
      
      public function sendTryPhoneNumber(param1:String, param2:String) : void
      {
         var_37.send(new TryPhoneNumberMessageComposer(param1,param2));
      }
      
      public function sendTryVerificationCode(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         param1 = param1.toUpperCase();
         var_37.send(new VerifyCodeMessageComposer(param1));
      }
      
      public function setNeverAgain() : void
      {
         var_37.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
         destroyCollectView();
      }
      
      public function setCollectViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyCollectView();
            createCollectMinimizedView();
         }
         else
         {
            destroyCollectMinimizedView();
            createCollectView();
         }
      }
      
      public function setVerifyViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyVerifyView();
            createVerifyMinimizedView();
         }
         else
         {
            destroyVerifyMinimizedView();
            createVerifyView();
         }
      }
      
      public function requestPhoneNumberCollectionReset() : void
      {
         destroyVerifyView();
         var_37.send(new ResetPhoneNumberStateMessageComposer());
      }
      
      private function onPhoneNumberResultMessage(param1:TryPhoneNumberResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 1)
         {
            case 0:
            case 2:
            case 8:
               destroyCollectView();
               _retryEnableTime = param1.getParser().millisToAllowProcessReset + getTimer();
               createVerifyView();
               break;
            case 1:
               destroyCollectView();
               break;
            case 3:
            case 4:
            case 5:
            case 9:
               if(!var_1379 && !var_1723)
               {
                  createCollectView();
               }
               else if(var_1379)
               {
                  setCollectViewMinimized(false);
               }
               _windowManager.alert("${generic.alert.title}","${phone.number.collect.error." + param1.getParser().resultCode + "}",0,null);
               var_1723.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onVerificationCodeResultMessage(param1:TryVerificationCodeResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 2)
         {
            case 0:
            case 1:
               destroyVerifyView();
               break;
            case 2:
               if(!var_1388 && !var_1693)
               {
                  _retryEnableTime = getTimer() + param1.getParser().millisecondsToAllowProcessReset;
                  createVerifyView();
               }
               else if(var_1388)
               {
                  setVerifyViewMinimized(false);
               }
               var_1693.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onStateMessage(param1:PhoneCollectionStateMessageEvent) : void
      {
         var _loc2_:int = param1.getParser().collectionStatusCode;
         var _loc3_:int = param1.getParser().phoneStatusCode;
         context.configuration.setProperty("phone.collection.status",_loc2_.toString());
         context.configuration.setProperty("phone.verification.status",_loc3_.toString());
         if(_loc2_ == 2)
         {
            return;
         }
         if(_loc2_ == 3 && (_loc3_ == 9 || _loc3_ == 1))
         {
            destroyCollectView();
            if(_loc2_ == 1)
            {
               createVerifyMinimizedView();
            }
            else
            {
               _retryEnableTime = param1.getParser().millisecondsToAllowProcessReset + getTimer();
               createVerifyView();
            }
            return;
         }
         switch(_loc3_)
         {
            case 0:
            case 9:
               createCollectView();
               break;
            case 2:
            case 3:
               destroyCollectView();
               destroyVerifyView();
               break;
            case 4:
            case 5:
            case 6:
               class_21.log("INVALID STATE!! Phone number / verify errors should not be handled here!");
         }
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get retryEnableTime() : int
      {
         return _retryEnableTime;
      }
      
      private function createCollectView() : void
      {
         destroyCollectView();
         var _loc2_:String = context.configuration.getProperty("phone.number.preferred.countries");
         var _loc1_:Array = _loc2_.split(",");
         var_1723 = new PhoneNumberCollectView(this,_loc1_);
      }
      
      private function createVerifyView() : void
      {
         destroyVerifyView();
         var_1693 = new VerificationCodeInputView(this);
      }
      
      private function createCollectMinimizedView() : void
      {
         destroyCollectMinimizedView();
         var_1379 = new PhoneNumberCollectMinimizedView(this);
         _toolbar.extensionView.attachExtension("phone_number",var_1379.window,12);
      }
      
      private function createVerifyMinimizedView() : void
      {
         destroyVerifyMinimizedView();
         var_1388 = new VerificationCodeInputMinimizedView(this);
         _toolbar.extensionView.attachExtension("verification_code",var_1388.window,12);
      }
      
      private function destroyCollectView() : void
      {
         if(var_1723)
         {
            var_1723.dispose();
            var_1723 = null;
         }
      }
      
      private function destroyVerifyView() : void
      {
         if(var_1693)
         {
            var_1693.dispose();
            var_1693 = null;
         }
      }
      
      private function destroyCollectMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("phone_number");
         if(var_1379)
         {
            var_1379.dispose();
            var_1379 = null;
         }
      }
      
      private function destroyVerifyMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("verification_code");
         if(var_1388)
         {
            var_1388.dispose();
            var_1388 = null;
         }
      }
   }
}

