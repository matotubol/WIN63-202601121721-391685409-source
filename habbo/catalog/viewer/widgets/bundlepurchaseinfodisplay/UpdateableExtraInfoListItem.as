package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   
   public class UpdateableExtraInfoListItem extends ExtraInfoListItem
   {
      
      public function UpdateableExtraInfoListItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:int = 0, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function update(param1:ExtraInfoItemData) : void
      {
         data = param1;
      }
   }
}

