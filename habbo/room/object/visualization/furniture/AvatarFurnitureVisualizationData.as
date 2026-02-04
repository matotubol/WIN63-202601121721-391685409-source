package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_1828;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
   
   public class AvatarFurnitureVisualizationData extends FurnitureVisualizationData
   {
      
      private var var_1837:AvatarVisualizationData;
      
      public function AvatarFurnitureVisualizationData()
      {
         super();
         var_1837 = new AvatarVisualizationData();
      }
      
      public function set avatarRenderer(param1:class_48) : void
      {
         var_1837.avatarRenderer = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1837.dispose();
         var_1837 = null;
      }
      
      public function getAvatar(param1:String, param2:Number, param3:String = null, param4:class_259 = null, param5:class_1828 = null) : class_1827
      {
         return var_1837.getAvatar(param1,param2,param3,param4,param5);
      }
   }
}

