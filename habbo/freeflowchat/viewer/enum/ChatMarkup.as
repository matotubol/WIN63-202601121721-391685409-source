package com.sulake.habbo.freeflowchat.viewer.enum
{
   public class ChatMarkup
   {
      
      public static const COLOUR_ARRAY:Array = [["red",9115929],["cyan",32639],["blue",19609],["green",32768],["purple",4980812]];
      
      public static const COLOUR_NAMES:Array = (function():Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in COLOUR_ARRAY)
         {
            _loc1_.push(_loc2_[0]);
         }
         return _loc1_;
      })();
      
      public function ChatMarkup()
      {
         super();
      }
      
      public static function applyColourToChat(param1:String) : String
      {
         for each(var _loc3_ in COLOUR_ARRAY)
         {
            if(param1.indexOf("@" + _loc3_[0] + "@") == 0)
            {
               var _loc2_:String = "#" + _loc3_[1].toString(16).toUpperCase();
               var _loc4_:String = param1.substring(_loc3_[0].length + 2,param1.length);
               if(_loc4_.charAt(0) == " ")
               {
                  _loc4_ = null.substr(1);
               }
               return "<font color=\"" + null + "\">" + null + "</font>";
            }
         }
         return param1;
      }
      
      public static function tokenize(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:String = "";
         var _loc6_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc4_);
            if(_loc3_ == "[")
            {
               if(_loc5_.length > 0)
               {
                  _loc2_.push(_loc5_);
                  _loc5_ = "";
               }
               _loc6_ = true;
               _loc5_ += _loc3_;
            }
            else if(_loc3_ == "]" && _loc6_)
            {
               _loc5_ += _loc3_;
               _loc2_.push(_loc5_);
               _loc5_ = "";
               _loc6_ = false;
            }
            else
            {
               _loc5_ += _loc3_;
            }
            _loc4_++;
         }
         if(_loc5_.length > 0)
         {
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      public static function applyToElements(param1:String) : String
      {
         var _loc7_:int = 0;
         var _loc11_:String = null;
         var _loc8_:String = null;
         var _loc9_:* = false;
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc2_:String = null;
         if(param1.length == 0)
         {
            return "";
         }
         var _loc5_:Array = tokenize(param1);
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc11_ = _loc5_[_loc7_];
            if(_loc11_.charAt(0) == "[" && _loc11_.charAt(_loc11_.length - 1) == "]" && (_loc11_.charAt(1) == "/" || _loc11_.length > 2 && _loc11_.length <= 10))
            {
               _loc8_ = _loc11_.substring(1,_loc11_.length - 1).toLowerCase();
               _loc9_ = _loc8_.charAt(0) == "/";
               if(_loc9_)
               {
                  _loc8_ = _loc8_.substr(1);
                  if(_loc6_.length > 0 && _loc6_[_loc6_.length - 1].tag == _loc8_)
                  {
                     _loc3_ = _loc6_.pop();
                     if(_loc8_ == "b" || _loc8_ == "i" || _loc8_ == "u")
                     {
                        _loc5_[_loc3_.index] = "<" + _loc8_ + ">";
                        _loc5_[_loc7_] = "</" + _loc8_ + ">";
                     }
                     else
                     {
                        _loc4_ = false;
                        for each(var _loc10_ in COLOUR_ARRAY)
                        {
                           if(_loc10_[0] == _loc8_)
                           {
                              _loc2_ = "#" + _loc10_[1].toString(16).toUpperCase();
                              _loc5_[_loc3_.index] = "<font color=\"" + _loc2_ + "\">";
                              _loc5_[_loc7_] = "</font>";
                              _loc4_ = true;
                              break;
                           }
                        }
                     }
                  }
               }
               else if(_loc8_ == "b" || _loc8_ == "i" || _loc8_ == "u" || COLOUR_NAMES.indexOf(_loc8_) != -1)
               {
                  _loc6_.push({
                     "tag":_loc8_,
                     "index":_loc7_
                  });
               }
            }
            _loc7_++;
         }
         return _loc5_.join("");
      }
   }
}

