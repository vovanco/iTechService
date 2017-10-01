class SubstitutePhone::Create < BaseOperation
  class Present < BaseOperation
    step Policy::Pundit(SubstitutePhone::Policy, :create?)
    failure :not_authorized!
    step Model(SubstitutePhone, :new)
    step Contract::Build(constant: SubstitutePhone::Contract::Base)
  end

  step Nested(Present)
  step Contract::Validate(key: :fault)
  failure :contract_invalid!
  step Contract::Persist()
  step ->(options, **) { options['result.message'] = I18n.t('substitute_phones.created') }
end
