package com.sulake.habbo.utils
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.class_50;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.system.Capabilities;
   import flash.text.Font;
   import flash.utils.ByteArray;
   
   public class CommunicationUtils
   {
      
      public static const SOL_PROPERTY_ENVIRONMENT:String = "environment";
      
      public static const SOL_PROPERTY_LOGIN_NAME:String = "login";
      
      public static const SOL_PROPERTY_CHARACTER_ID:String = "userid";
      
      public static const SOL_PROPERTY_CHARACTER_UNIQUE_ID:String = "useruniqueid";
      
      public static const SOL_PROPERTY_REMEMBER_LOGIN:String = "autologin";
      
      public static const SOL_PROPERTY_LOGIN_METHOD:String = "loginmethod";
      
      public static const SOL_PROPERTY_MACHINE_ID:String = "machineid";
      
      public static const SOL_PROPERTY_APP_RATER_STATUS:String = "ratingstatus";
      
      public static const SOL_PROPERTY_APP_RATER_TIMESTAMP:String = "ratingstatustime";
      
      public static const LOGIN_METHOD_HABBO:String = "habbo";
      
      public static const const_611:String = "facebook";
      
      private static const SOL_ID:String = "fuselogin";
      
      private static const SOL_PROPERTY_PASSWORD:String = "password";
      
      private static var var_4271:Boolean;
      
      public function CommunicationUtils()
      {
         super();
      }
      
      public static function clearAllLoginData() : void
      {
         writeSOLProperty("loginmethod",null);
         writeSOLProperty("environment",null);
         writeSOLProperty("userid",null);
         writeSOLProperty("autologin",null);
         CommunicationUtils.forcedAutoLoginEnabled = false;
      }
      
      public static function get forcedAutoLoginEnabled() : Boolean
      {
         return var_4271;
      }
      
      public static function set forcedAutoLoginEnabled(param1:Boolean) : void
      {
         var_4271 = param1;
      }
      
      public static function resetPassword() : void
      {
         writeSOLProperty("password","");
      }
      
      public static function restorePassword() : String
      {
         var _loc1_:String = null;
         if(!_loc1_)
         {
            _loc1_ = readSOLString("password","");
         }
         return _loc1_;
      }
      
      public static function propertyExists(param1:String) : Boolean
      {
         var _loc3_:SharedObject = null;
         var _loc2_:Object = null;
         try
         {
            _loc3_ = SharedObject.getLocal("fuselogin","/");
            _loc2_ = _loc3_.data[param1];
            if(_loc2_ == null)
            {
               return false;
            }
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public static function writeSOLProperty(param1:String, param2:Object) : void
      {
         var _loc3_:SharedObject = null;
         try
         {
            _loc3_ = SharedObject.getLocal("fuselogin","/");
            _loc3_.data[param1] = param2;
            _loc3_.flush();
         }
         catch(e:Error)
         {
            class_21.log("Error writing SOL propert \'" + param1 + "\' with value \'" + param2 + "\'");
         }
      }
      
      public static function readSOLProperty(param1:String, param2:Object = null) : Object
      {
         var _loc4_:SharedObject = null;
         var _loc3_:Object = null;
         try
         {
            _loc4_ = SharedObject.getLocal("fuselogin","/");
            _loc3_ = _loc4_.data[param1];
            if(_loc3_ == null)
            {
               _loc3_ = param2;
            }
            if(param1 == "environment" && _loc3_)
            {
               _loc3_ = _loc3_.replace("hh","");
               _loc3_ = _loc3_.replace("br","pt");
               _loc3_ = _loc3_.replace("us","en");
            }
            return _loc3_;
         }
         catch(e:Error)
         {
            class_21.log("Error reading SOL property \'" + param1 + "\'");
         }
         return param2;
      }
      
      public static function readSOLString(param1:String, param2:String = null) : String
      {
         var _loc3_:Object = readSOLProperty(param1,param2);
         if(!_loc3_)
         {
            return null;
         }
         return String(_loc3_);
      }
      
      public static function readSOLBoolean(param1:String, param2:String = null) : Boolean
      {
         var _loc3_:String = String(readSOLProperty(param1,param2));
         return _loc3_ != null && (_loc3_.toLowerCase() == "true" || _loc3_ == "1");
      }
      
      public static function readSOLInteger(param1:String, param2:String = null) : int
      {
         var _loc3_:Object = readSOLProperty(param1,param2);
         return parseInt(String(_loc3_));
      }
      
      public static function readSOLFloat(param1:String, param2:String = null) : Number
      {
         var _loc3_:Object = readSOLProperty(param1,param2);
         return parseFloat(String(_loc3_));
      }
      
      public static function decodeFromBitmap(param1:BitmapData) : String
      {
         var _loc18_:int = 0;
         var _loc17_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc3_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:Point = new Point(4,39);
         var _loc2_:Point = new Point(80,30);
         var _loc14_:ByteArray = param1.getPixels(param1.rect);
         var _loc16_:int = param1.width;
         var _loc7_:String = "";
         var _loc12_:uint = 0;
         var _loc19_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         _loc8_ = 1;
         var _loc10_:int = _loc4_.y + _loc2_.y;
         var _loc11_:int = _loc4_.x + _loc2_.x;
         _loc18_ = _loc4_.y;
         while(_loc18_ < _loc10_)
         {
            _loc17_ = _loc4_.x;
            while(_loc17_ < _loc11_)
            {
               _loc5_ = ((_loc18_ + _loc13_) * _loc16_ + _loc17_) * 4;
               _loc6_ = int(_loc8_);
               while(_loc6_ < 4)
               {
                  _loc14_.position = _loc5_ + _loc6_;
                  _loc3_ = _loc14_.readUnsignedByte();
                  _loc9_ = uint(_loc3_ & 1);
                  _loc19_ |= _loc9_ << 7 - _loc12_;
                  if(_loc12_ == 7)
                  {
                     _loc7_ += String.fromCharCode(_loc19_);
                     _loc19_ = 0;
                     _loc12_ = 0;
                  }
                  else
                  {
                     _loc12_++;
                  }
                  _loc6_++;
               }
               if(_loc17_ % 2 == 0)
               {
                  _loc13_++;
               }
               _loc17_++;
            }
            _loc13_ = 0;
            _loc18_++;
         }
         return _loc7_;
      }
      
      public static function xor(param1:String, param2:String) : String
      {
         var _loc7_:int = 0;
         var _loc5_:* = 0;
         var _loc3_:String = "";
         var _loc6_:int = 0;
         var _loc4_:int = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = uint(param1.charCodeAt(_loc7_));
            _loc3_ += String.fromCharCode(_loc5_ ^ param2.charCodeAt(_loc6_));
            if(++_loc6_ == param2.length)
            {
               _loc6_ = 0;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public static function generateFingerprint() : String
      {
         var _loc8_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc9_:Array = null;
         var _loc1_:Array = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc11_:ByteArray = null;
         var _loc12_:MD5 = null;
         var _loc7_:String = null;
         try
         {
            if(ExternalInterface.available)
            {
               _loc8_ = ExternalInterface.call("window.navigator.userAgent.toString");
               _loc4_ = ExternalInterface.call("FlashExternalInterface.listPlugins");
            }
            _loc2_ = Capabilities.serverString;
            _loc5_ = new String(new Date().timezoneOffset);
            _loc9_ = Font.enumerateFonts(true);
            _loc1_ = [];
            for each(var _loc10_ in _loc9_)
            {
               if(!(_loc10_.fontType == "embedded" || _loc10_.fontStyle != "regular"))
               {
                  _loc1_.push(_loc10_.fontName);
               }
            }
            _loc3_ = _loc1_.join(",");
            _loc6_ = _loc8_ + "#" + _loc2_ + "#" + _loc5_ + "#" + _loc4_ + "#" + _loc3_;
            _loc11_ = new ByteArray();
            _loc11_.writeUTFBytes(_loc6_);
            _loc12_ = new MD5();
            _loc7_ = class_50.fromArray(_loc12_.hash(_loc11_),false);
            if(!_loc4_ || _loc4_.length == 0)
            {
               return "~" + _loc7_;
            }
            return _loc7_;
         }
         catch(e:Error)
         {
         }
         return "";
      }
      
      public static function generateRandomHexString(param1:uint = 16) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc3_ = Math.random() * 255;
            _loc2_ += _loc3_.toString(16);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function removeProtocol(param1:String) : String
      {
         param1 = param1.replace("http://","");
         return param1.replace("https://","");
      }
   }
}

