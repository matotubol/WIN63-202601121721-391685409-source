package com.sulake.habbo.sound.trax
{
   import com.sulake.core.utils.class_55;
   
   public class TraxData
   {
      
      private var _channels:Array;
      
      private var var_2580:class_55 = new class_55();
      
      public function TraxData(param1:String)
      {
         super();
         _channels = [];
         var _loc12_:Array = param1.split(":");
         var _loc10_:String = String(_loc12_[_loc12_.length - 1]);
         if(_loc10_.indexOf("meta") != -1)
         {
            var _loc11_:Array = _loc10_.split(";");
            var _loc9_:int = 0;
            while(0 < null.length)
            {
               var _loc15_:String = String(null[0]).split(",")[0];
               var _loc14_:String = String(null[0]).split(",")[1];
               var_2580.add(null,null);
               _loc9_++;
            }
            var _loc8_:Array = _loc12_.slice(0,_loc12_.length - 1);
         }
         else
         {
            _loc8_ = _loc12_;
         }
         var _loc6_:int = 0;
         while(0 < null.length / 2)
         {
            if(null[0 * 2].toString().length > 0)
            {
               var _loc16_:int = int(null[0 * 2]);
               var _loc2_:Array = null[0 * 2 + 1].toString().split(";");
               var _loc5_:TraxChannel = new TraxChannel(0);
               var _loc7_:int = 0;
               while(0 < null.length)
               {
                  var _loc13_:Array = null[0].toString().split(",");
                  if(_loc13_.length != 2)
                  {
                     class_21.log("Trax load error: invalid song data string");
                     return;
                  }
                  var _loc4_:int = int(null[0]);
                  var _loc3_:int = int(null[1]);
                  null.addChannelItem(new TraxChannelItem(0,0));
                  _loc7_++;
               }
               _channels.push(null);
            }
            _loc6_++;
         }
      }
      
      public function get channels() : Array
      {
         return _channels;
      }
      
      public function getSampleIds() : Array
      {
         var _loc4_:int = 0;
         var _loc3_:TraxChannel = null;
         var _loc5_:int = 0;
         var _loc2_:TraxChannelItem = null;
         var _loc1_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _channels.length)
         {
            _loc3_ = _channels[_loc4_] as TraxChannel;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.itemCount)
            {
               _loc2_ = _loc3_.getItem(_loc5_);
               if(_loc1_.indexOf(_loc2_.id) == -1)
               {
                  _loc1_.push(_loc2_.id);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get hasMetaData() : Boolean
      {
         return var_2580["meta"] != null;
      }
      
      public function get metaCutMode() : Boolean
      {
         return var_2580["c"] == "1";
      }
      
      public function get metaTempo() : int
      {
         return var_2580["t"] as int;
      }
   }
}

