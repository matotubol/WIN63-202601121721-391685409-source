package com.sulake.habbo.phonenumber
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2466;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import package_69.JSONDecoder;
   
   public class PhoneNumberCollectView
   {
      
      private static const INPUT_MAX_CHARS:int = 30;
      
      private static const ALL_COUNTRY_CODES:Array = ["VU","EC","VN","VI","DZ","VG","VE","DM","VC","DO","VA","DE","UZ","UY","DK","DJ","US","UG","UA","ET","ES","ER","EH","EG","EE","TZ","TT","TW","TV","GD","GE","GF","GA","GB","FR","FO","FK","FJ","FM","FI","WS","GY","GW","GU","GT","GR","GQ","WF","GP","GN","GM","GL","GI","GH","GG","RE","RO","AT","AS","AR","QA","AW","AU","AZ","BA","PT","AC","AD","PW","AG","AE","PR","PS","AF","AL","AI","AO","PY","AM","BW","TG","BY","TD","TK","BS","TJ","BR","BT","TH","TO","TN","TM","TL","CA","BZ","TR","BF","SV","BG","BH","SS","BI","ST","SY","BB","SZ","BD","BE","SX","BN","BO","BQ","BJ","TC","BL","TA","BM","CZ","SD","CY","SC","CX","CW","SE","SH","CV","SG","CU","SJ","SI","SL","SK","SN","SM","SO","SR","CI","RS","CG","CH","RU","RW","CF","CC","CD","CR","CO","CM","CN","SA","CK","SB","CL","LV","LU","LT","LY","LS","LR","MG","MH","ME","MF","MK","ML","MC","MD","MA","MV","MU","MX","MW","MZ","MY","MN","MM","MP","MO","MR","MQ","MT","MS","NF","NG","NI","NL","NA","NC","NE","NZ","NU"
      ,"NR","NP","NO","OM","PL","PM","PH","PK","PE","PF","PG","PA","HK","ZA","HN","HR","HT","HU","ZM","ZW","ID","IE","IL","IM","IN","IO","IQ","IR","YE","IS","IT","JE","YT","JP","JO","JM","KI","KH","KG","KE","KP","KR","KM","KN","KW","KY","KZ","LA","LC","LB","LI","LK"];
      
      private var var_59:HabboPhoneNumber;
      
      private var _window:class_2250;
      
      private var _inputTextNeedsClearing:Boolean = true;
      
      private var var_2011:Array;
      
      public function PhoneNumberCollectView(param1:HabboPhoneNumber, param2:Array)
      {
         super();
         var_59 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_59 = null;
      }
      
      public function handleSubmitFailure(param1:int) : void
      {
         _window.findChildByName("phone_number_input").caption = "";
         _inputTextNeedsClearing = true;
         setInputStates(true);
      }
      
      private function createWindow(param1:Array) : void
      {
         if(_window)
         {
            return;
         }
         _window = class_2250(var_59.windowManager.buildFromXML(XML(var_59.assets.getAssetByName("phonenumber_collect_xml").content)));
         _window.center();
         _window.findChildByName("never_link").procedure = onInput;
         _window.findChildByName("skip_link").procedure = onInput;
         _window.findChildByName("ok_button").procedure = onInput;
         _window.findChildByName("header_button_close").procedure = onInput;
         _window.findChildByName("phone_number_input").procedure = onInput;
         ITextFieldWindow(_window.findChildByName("phone_number_input")).maxChars = 30;
         var _loc6_:String = var_59.localizationManager.getLocalization("phone.number.collect.countries") || "{}";
         var _loc3_:Object = new JSONDecoder(_loc6_,false).getValue();
         var _loc8_:Array = ALL_COUNTRY_CODES.concat();
         var_2011 = [];
         for each(var _loc5_ in _loc8_)
         {
            var _loc9_:String = _loc3_[null];
            if(_loc9_ != null && null.length > 0)
            {
               var_2011.push({
                  "code":null,
                  "name":null
               });
            }
         }
         var_2011.sortOn("name");
         var _loc7_:int = param1.length - 1;
         while(true)
         {
            _loc5_ = param1[0];
            if(ALL_COUNTRY_CODES.indexOf(null) != -1)
            {
               var _loc4_:String = _loc3_[null];
               var_2011.unshift({
                  "code":null,
                  "name":null
               });
            }
            _loc7_--;
         }
      }
      
      private function createCountrySelectorMenuItem(param1:String, param2:String) : class_1741
      {
         var _loc3_:class_1812 = class_1812(var_59.windowManager.buildFromXML(XML(var_59.assets.getAssetByName("phonenumber_country_menu_item_xml").content)));
         _loc3_.name = param1;
         _loc3_.findChildByName("country_code").caption = param2;
         return _loc3_;
      }
      
      private function get selectedCountryCode() : String
      {
         var _loc2_:class_2466 = class_2466(_window.findChildByName("country_list"));
         if(_loc2_.selection == -1)
         {
            return "NOT_SELECTED";
         }
         var _loc1_:Object = var_2011[_loc2_.selection];
         return _loc1_ != null ? _loc1_.code : "--";
      }
      
      private function onNeverAgainConfirmClose(param1:class_2001, param2:class_1758) : void
      {
         if(param2.type == "WE_OK" && var_59)
         {
            var_59.setNeverAgain();
         }
         param1.dispose();
      }
      
      private function setInputStates(param1:Boolean) : void
      {
         _window.findChildByName("ok_button").disable();
         if(param1)
         {
            _window.findChildByName("phone_number_input").enable();
            _window.findChildByName("never_link").visible = true;
            _window.findChildByName("skip_link").visible = true;
            _window.findChildByName("header_button_close").enable();
            _window.findChildByName("country_list").enable();
         }
         else
         {
            _window.findChildByName("phone_number_input").disable();
            _window.findChildByName("never_link").visible = false;
            _window.findChildByName("skip_link").visible = false;
            _window.findChildByName("header_button_close").disable();
            _window.findChildByName("country_list").disable();
         }
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "skip_link":
                  var_59.setCollectViewMinimized(true);
                  break;
               case "never_link":
                  var_59.windowManager.confirm("${phone.number.never.again.confirm.title}","${phone.number.never.again.confirm.text}",0,onNeverAgainConfirmClose);
                  break;
               case "ok_button":
                  var_59.sendTryPhoneNumber(selectedCountryCode,_window.findChildByName("phone_number_input").caption);
                  setInputStates(false);
                  break;
               case "phone_number_input":
                  if(_inputTextNeedsClearing)
                  {
                     _window.findChildByName("phone_number_input").caption = "";
                     _inputTextNeedsClearing = false;
                  }
                  ITextFieldWindow(_window.findChildByName("phone_number_input")).textColor = 0;
            }
         }
         if(param1.type == "WKE_KEY_UP" && param1.target.name == "phone_number_input")
         {
            if(_window.findChildByName("phone_number_input").caption != null && _window.findChildByName("phone_number_input").caption.length > 0)
            {
               _window.findChildByName("ok_button").enable();
            }
            else
            {
               _window.findChildByName("ok_button").disable();
            }
         }
      }
   }
}

