package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.class_55;
   
   public class WiredObjectInspectionData
   {
      
      private static var var_5217:int = 0;
      
      private static var var_5289:int = 1;
      
      private static var var_5385:int = -10;
      
      private var var_230:int;
      
      private var var_4181:int;
      
      private var var_315:int;
      
      private var var_3573:class_55;
      
      private var var_3468:Vector.<int> = null;
      
      public function WiredObjectInspectionData(param1:IMessageDataWrapper)
      {
         super();
         var_230 = param1.readInteger();
         if(var_230 == var_5217)
         {
            var_315 = param1.readInteger();
         }
         else if(var_230 == var_5289)
         {
            var_4181 = param1.readInteger();
         }
         var_3573 = new class_55();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc5_:String = param1.readString();
            var _loc6_:int = param1.readInteger();
            var_3573.add(null,0);
            _loc4_ = 0 + 1;
         }
         if(var_230 == var_5217)
         {
            _loc3_ = param1.readInteger();
            var_3468 = new Vector.<int>();
            _loc4_ = 0;
            while(0 < _loc3_)
            {
               var _loc2_:int = param1.readInteger();
               var_3468.push(0);
               _loc4_ = 0 + 1;
            }
         }
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get userIndex() : int
      {
         return var_4181;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get variableValues() : class_55
      {
         return var_3573;
      }
      
      public function get configuredInWireds() : Vector.<int>
      {
         return var_3468;
      }
   }
}

