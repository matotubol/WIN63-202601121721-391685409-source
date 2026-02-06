package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FloorHeightMapMessageEventParser implements IMessageParser
   {
      
      private var _text:String = "";
      
      private var var_936:Array = [];
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      private var var_337:Number = 0;
      
      private var _fixedWallsHeight:int = -1;
      
      private var var_2296:Vector.<AreaHideMessageData>;
      
      private var var_4980:int;
      
      private var var_4105:int;
      
      private var var_5073:Number;
      
      public function FloorHeightMapMessageEventParser()
      {
         super();
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function get fixedWallsHeight() : int
      {
         return _fixedWallsHeight;
      }
      
      public function get scale() : Number
      {
         return var_337;
      }
      
      public function getTileHeight(param1:int, param2:int) : int
      {
         if(param1 < 0 || param1 >= width || param2 < 0 || param2 >= height)
         {
            return -110;
         }
         var _loc3_:Array = var_936[param2] as Array;
         return _loc3_[param1];
      }
      
      public function flush() : Boolean
      {
         var_936 = [];
         _width = 0;
         var_385 = 0;
         _text = "";
         _fixedWallsHeight = -1;
         var_2296 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc9_:Boolean = param1.readBoolean();
         _fixedWallsHeight = param1.readInteger();
         _text = param1.readString();
         var _loc6_:Array = _text.split("\r");
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:Array = null;
         var _loc12_:int = int(_loc6_.length);
         if(_loc12_ > 0 && _loc6_[_loc12_ - 1] == "")
         {
            _loc12_ -= 1;
         }
         var _loc7_:int = 0;
         var _loc10_:String = null;
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc10_ = _loc6_[_loc4_] as String;
            if(_loc10_.length > _loc7_)
            {
               _loc7_ = _loc10_.length;
            }
            _loc4_++;
         }
         var_936 = [];
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               _loc2_.push(-110);
               _loc3_++;
            }
            var_936.push(_loc2_);
            _loc4_++;
         }
         _width = _loc7_;
         var_385 = _loc12_;
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc2_ = var_936[_loc4_] as Array;
            _loc10_ = _loc6_[_loc4_] as String;
            if(_loc10_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_.length)
               {
                  var _loc8_:String = _loc10_.charAt(_loc3_);
                  if(_loc8_ != "x" && null != "X")
                  {
                     _loc11_ = parseInt(null,36);
                  }
                  else
                  {
                     _loc11_ = -110;
                  }
                  _loc2_[_loc3_] = _loc11_;
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         var_337 = _loc9_ ? 32 : 64;
         var_2296 = new Vector.<AreaHideMessageData>();
         var _loc13_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc13_)
         {
            var_2296.push(new AreaHideMessageData(param1));
            _loc5_++;
         }
         var_4980 = param1.readInteger();
         var_4105 = param1.readInteger();
         var_5073 = param1.readFloat();
         return true;
      }
      
      public function get areaHideData() : Vector.<AreaHideMessageData>
      {
         return var_2296;
      }
      
      public function get cameraInitX() : int
      {
         return var_4980;
      }
      
      public function get cameraInitY() : int
      {
         return var_4105;
      }
      
      public function get cameraInitZ() : Number
      {
         return var_5073;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}

