class Dataset < ActiveRecord::Base
  # Constants
  MAX_ATTACHMENTS = 5

  # Associations
  has_many :attachments, :class_name => '::Attachment', :dependent => :destroy # class_name to avoid collision with Paperclip
  has_and_belongs_to_many :apps
  
  # Tagging
  acts_as_taggable
  acts_as_taggable_on :certifications, :standards
  
  # Validations
  validates_presence_of :title, :description
  validates_length_of :title, :maximum => 256
  validates_length_of :description, :maximum => 10.kilobytes
  validates_date :start_date, :allow_blank => true
  validates_date :end_date, :allow_blank => true
  validates_inclusion_of :category, :in => Configs.select_lists['dataset_categories'].values.keys, :if => :category

  #validates_each :attachments do |record, attr_name, value|
  #  value.each do |attachment|
  #    record.attachments.delete(attachment) unless attachment.valid?
  #  end
  #end

  # Set attributes available for mass-assignment
  attr_accessible :title, :description, :start_date, :end_date, :is_featured, :attachments_attributes, :category, :tag_list, :standard_list, :certification_list
  accepts_nested_attributes_for :attachments, :allow_destroy => true
end
