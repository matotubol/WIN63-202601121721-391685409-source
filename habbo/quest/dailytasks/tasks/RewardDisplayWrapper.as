package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import package_139.class_3743;
   
   public class RewardDisplayWrapper implements IProductDisplayInfo
   {
      
      private var var_2788:class_3743;
      
      public function RewardDisplayWrapper(param1:class_3743)
      {
         super();
         var_2788 = param1;
      }
      
      public function get productTypeId() : int
      {
         return var_2788.productItemTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return var_2788.rewardTypeId;
      }
      
      public function get petFigureString() : String
      {
         return var_2788.extraParams;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
   }
}

