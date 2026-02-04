package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.window.class_38;
   import package_13.class_2961;
   import package_13.class_3176;
   
   public class ClubGiftController
   {
      
      private var var_16:ClubGiftWidget;
      
      private var var_3863:int;
      
      private var var_2402:int;
      
      private var _offers:Array;
      
      private var var_1628:class_55;
      
      private var _catalog:HabboCatalog;
      
      private var var_69:ClubGiftConfirmationDialog;
      
      public function ClubGiftController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         if(var_69)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      public function set widget(param1:ClubGiftWidget) : void
      {
         var_16 = param1;
         _catalog.connection.send(new class_3176());
      }
      
      public function get daysUntilNextGift() : int
      {
         return var_3863;
      }
      
      public function get giftsAvailable() : int
      {
         return var_2402;
      }
      
      public function setInfo(param1:int, param2:int, param3:Array, param4:class_55) : void
      {
         var_3863 = param1;
         var_2402 = param2;
         _offers = param3;
         var_1628 = param4;
         if(var_16)
         {
            var_16.update();
         }
      }
      
      public function selectGift(param1:class_1793) : void
      {
         closeConfirmation();
         var_69 = new ClubGiftConfirmationDialog(this,param1);
      }
      
      public function confirmSelection(param1:String) : void
      {
         if(!param1 || !_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new class_2961(param1));
         var_2402 = var_2402 - 1;
         var_16.update();
         closeConfirmation();
      }
      
      public function closeConfirmation() : void
      {
         if(var_69)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      public function getOffers() : Array
      {
         return _offers;
      }
      
      public function getGiftData() : class_55
      {
         return var_1628;
      }
      
      public function get hasClub() : Boolean
      {
         if(!_catalog || !_catalog.getPurse())
         {
            return false;
         }
         return _catalog.getPurse().clubDays > 0;
      }
      
      public function get windowManager() : class_38
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.windowManager;
      }
      
      public function get localization() : class_27
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.localization;
      }
      
      public function get assets() : class_40
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.assets;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.roomEngine;
      }
      
      public function getProductData(param1:String) : class_1949
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getProductData(param1);
      }
      
      public function get purse() : class_1831
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getPurse();
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
   }
}

