/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

	DECLARE @start_time DATETIME,@end_time DATETIME , @t_start_time DATETIME,@t_end_time DATETIME;
	PRINT 'Loading Bronze Layer';
	PRINT '=====================================================';
	PRINT 'Insert data from CRM tables.'
	PRINT '=====================================================';

	BEGIN try
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		SET @t_start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		SET @start_time = GETDATE();

		PRINT '>> Loading data form cust_info.csv';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		SET @start_time = GETDATE();
		PRINT '>> Loading data form prd_info.csv';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		SET @start_time = GETDATE();
		PRINT '>> Loading data form sales_details.csv';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		PRINT 'Insert data from ERP tables.'
		PRINT '=====================================================';
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		SET @start_time = GETDATE();
		PRINT '>> Loading data form CUST_AZ12.csv';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		SET @start_time = GETDATE();
		PRINT '>> Loading data form LOC_A101.csv';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		SET @start_time = GETDATE();
		PRINT '>> Loading data form PX_CAT_G1V2.csv';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		SET @end_time = GETDATE();
		PRINT '>> Duration: '+ CAST(DATEDIFF(second, @start_time , @end_time)AS VARCHAR) + ' seconds';
		PRINT '=====================================================';

		SET @t_end_time = GETDATE();
		PRINT 'Loading Bronze Layer is Completed!';
		PRINT 'Total duration: '+ CAST(DATEDIFF(second ,@t_start_time ,@t_end_time) AS VARCHAR) + ' seconds';
	END try

	BEGIN catch
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
	END catch
END
