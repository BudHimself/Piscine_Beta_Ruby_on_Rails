require 'sqlite3'

class FtQueryController < ApplicationController
  def index() end

  def create_db
    $db = SQLite3::Database.new('db/ft_sql')
    $db.close if $db
    redirect_to action: :index
  end

  def create_table
    $db = SQLite3::Database.open('db/ft_sql')
    $db.execute "CREATE TABLE IF NOT EXISTS clock_watch(ts_id INTEGER PRIMARY KEY,
    day INT,
    month INT,
    year INT,
    hour INT,
    min INT,
    sec INT,
    race INT,
    name STRING(50),
    lap INT);"
    $db.execute "CREATE TABLE IF NOT EXISTS race(r_id INTEGER PRIMARY KEY,
    start STRING(50));"
    $db.close if $db
    redirect_to action: :index
  end

  def start_race() end

  def insert_time_stamp() end

  def drop_table() end

  def delete_last() end

  def destroy_all() end

  def all_by_name() end

  def all_by_race() end

  def update_time_stamp() end
end
