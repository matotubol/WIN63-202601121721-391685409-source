package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.class_2108;
   
   [SecureSWF(rename="true")]
   public class class_3265
   {
      
      private var var_197:int = 0;
      
      private var var_61:int = 0;
      
      private var var_24:IStuffData = new class_2108();
      
      public function class_3265(param1:int, param2:int, param3:IStuffData)
      {
         super();
         var_197 = param1;
         var_61 = param2;
         var_24 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get data() : IStuffData
      {
         return var_24;
      }
   }
}

