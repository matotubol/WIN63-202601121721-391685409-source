package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class class_2977 extends class_2107 implements IStuffData
   {
      
      public static const FORMAT_KEY:int = 6;
      
      private var var_61:String = "";
      
      private var var_2462:int = -1;
      
      private var var_2461:int = -1;
      
      private var var_80:Vector.<HighScoreData>;
      
      public function class_2977()
      {
         super();
      }
      
      public function get scoreType() : int
      {
         return var_2462;
      }
      
      public function get clearType() : int
      {
         return var_2461;
      }
      
      public function get entries() : Vector.<HighScoreData>
      {
         return var_80;
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var_80 = new Vector.<HighScoreData>();
         var_61 = param1.readString();
         var_2462 = param1.readInteger();
         var_2461 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:HighScoreData = new HighScoreData();
            null.score = param1.readInteger();
            var _loc4_:int = param1.readInteger();
            var _loc6_:int = 0;
            var_80.push(null);
            _loc5_++;
         }
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         var_80 = new Vector.<HighScoreData>();
         super.initializeFromRoomObjectModel(param1);
         var_2462 = param1.getNumber("furniture_highscore_score_type");
         var_2461 = param1.getNumber("furniture_highscore_clear_type");
         var _loc3_:int = param1.getNumber("furniture_highscore_data_entry_count");
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:HighScoreData = new HighScoreData();
            null.score = param1.getNumber("furniture_highscore_data_entry_base_score_" + 0);
            null.users = param1.getStringArray("furniture_highscore_data_entry_base_users_" + 0);
            var_80.push(null);
            _loc4_++;
         }
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HighScoreData = null;
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",6);
         param1.setNumber("furniture_highscore_score_type",var_2462);
         param1.setNumber("furniture_highscore_clear_type",var_2461);
         if(var_80)
         {
            param1.setNumber("furniture_highscore_data_entry_count",var_80.length);
            _loc3_ = 0;
            while(_loc3_ < var_80.length)
            {
               _loc2_ = var_80[_loc3_];
               param1.setNumber("furniture_highscore_data_entry_base_score_" + _loc3_,_loc2_.score);
               param1.setStringArray("furniture_highscore_data_entry_base_users_" + _loc3_,_loc2_.users);
               _loc3_++;
            }
         }
      }
      
      override public function getLegacyString() : String
      {
         return var_61;
      }
   }
}

